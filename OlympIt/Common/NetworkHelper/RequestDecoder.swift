//
//  RequestDecoder.swift
//  OlympIt
//
//  Created by Nariman on 13.04.2024.
//

import Moya
import Foundation

public class RequestDecoder {
    public static let shared = RequestDecoder()

    public init() {}

    public func decodeResult<T: Decodable>(_ result: Result<Response, MoyaError>,
                                         for type: T.Type,
                                         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) -> Result<T, NetworkError> {
        jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
        switch result {
        case .success(let response):
            response.data.printAsJSON()
            do {
                let permission = try? JSONDecoder().decode(BaseError.self, from: response.data)
                if permission?.codeType == .permissionDenied {
                    return .failure(.permissionDenied(code: permission?.code ?? ""))
                } else if permission?.codeType == .needUpgrade {
                    return .failure(.permissionDenied(code: permission?.code ?? ""))
                }
                let decodedData = try jsonDecoder.decode(T.self, from: response.data)
                return .success(decodedData)
            } catch {
                dump(error)
                if let errorResponse = try? JSONDecoder().decode(BaseError.self, from: response.data) {
                    return .failure(validateOnErrors(error, response: response.response, baseError: errorResponse))
                }
                return .failure(validateOnErrors(error, response: response.response))
            }
        case .failure(let error):
            return .failure(.moyaError(error))
        }
    }
    
    public func decodeSuccessResult(_ result: Result<Response, MoyaError>) -> Result<Bool, NetworkError> {
        switch result {
        case .success(let response):
            response.data.printAsJSON()
            do {
                let permission = try? JSONDecoder().decode(BaseError.self, from: response.data)
                if permission?.codeType == .permissionDenied {
                    return .failure(.permissionDenied(code: permission?.code ?? ""))
                } else if permission?.codeType == .needUpgrade {
                    return .failure(.permissionDenied(code: permission?.code ?? ""))
                }
                try response.filterSuccessfulStatusCodes()
                return .success(true)
            } catch let error {
                dump(error)
                if let errorResponse = try? JSONDecoder().decode(BaseError.self, from: response.data) {
                    return .failure(.base(errorResponse))
                }
                return .failure(.errorWithCode(description: "Error response decode error. Error: \(error)"))
            }
        case .failure(let error):
            return .failure(.moyaError(error))
        }
    }

    private var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private func validateOnErrors(_ error: Error, response: HTTPURLResponse?, baseError: BaseError? = nil) -> NetworkError {
        guard let response = response else { return .unsupportedError }
        let message = error.localizedDescription
        let statusCode = response.statusCode
        switch statusCode {
        case 400:
            if let baseError = baseError {
                return .invalidRequest(baseError.description)
            }
            return .invalidRequest("invalid_error")
        case 401:
            if let baseError = baseError {
                return .authProblem(baseError.description)
            }
            return .authProblem("auth_problem")
        case 403:
            return .accessProblem(code: statusCode, message: message, url: response.url?.absoluteString)
        case _ where statusCode >= 500:
            return .serverError(code: statusCode, message: message, url: response.url?.absoluteString)
        default:
            if let baseError = baseError {
                return .invalidRequest(baseError.description)
            }
            return .unsupportedError
        }
    }
}

public enum NetworkError: Error {
    case decodeFailure
    case moyaError(_ error: MoyaError)
    case jiraTokenMissed
    case errorWithCode(code: String? = nil, description: String)
    case invalidRequest(String)
    case base(BaseError)
    case authProblem(String)
    case accessProblem(code: Int, message: String, url: String? = nil)
    case serverError(code: Int, message: String, url: String? = nil)
    case notFound(code: Int, message: String, url: String? = nil)
    case serverIsNotAvaivable(code: Int, message: String, url: String? = nil)
    case jsonParsingError(json: String, url: String? )
    case error
    case unsupportedError
    case permissionDenied(code: String)
    
    public var description: String {
        switch self {
        case .base(let error): return error.description // error.code + ": " +
        case .decodeFailure: return "Decode error"
        case .jiraTokenMissed: return "Jira token missed"
        case .moyaError(let error): return "Network error: \(error.errorDescription ?? "")"
        case .errorWithCode(let code, let descr):
            guard let code = code else {
                return  "Message: \(descr)"
            }
            return  "Message: \(descr) Code: \(code)"
        case .authProblem(let error):
            return error
        case .accessProblem(_, let message, _):
            return message
        case .serverError(_, let message, _):
            return message
        case .notFound(_, let message, _):
            return message
        case .serverIsNotAvaivable(_, let message, _):
            return message
        case .jsonParsingError(_, _):
            return "error_standard"
        case .error:
            return "error_standard"
        case .unsupportedError:
            return "error_standard"
        case .invalidRequest(let descr):
            return descr
        case .permissionDenied(let code):
            return code
        }
    }
    
    public var localizedDescription: String {
        return description
    }
}

public struct BaseError: Codable {
    public let code: String
    public let description: String
    
    public enum CodeType: String, CaseIterable {
        case permissionDenied = "permission_denied"
        case needUpgrade = "NEED_UPGRADE"
        case notAuthorized = "NOT_AUTHENTICATED"
        case other
    }
    
    public var codeType: CodeType {
        return CodeType(rawValue: code) ?? .other
    }
}

extension Data {
   /// Serialize data to JSON and print it
   func printAsJSON() {
       do {
           // make sure this JSON is in the format we expect
           if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
               // try to read out a string array
               print("Dictionary = ", json)
           } else if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [[String: Any]] {
               print("Array of Dictionary = ", json)
           } else {
               print("Cound't parse data")
           }
       } catch let error as NSError {
           print("Failed to load: \(error.localizedDescription)")
       }
   }
}
