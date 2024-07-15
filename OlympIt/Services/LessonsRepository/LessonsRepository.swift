//
//  OlympRepository.swift
//  OlympIt
//
//  Created by Nariman on 07.05.2024.
//

import FirebaseFirestore

enum InitialLessonType: String, CaseIterable {
    case olymp
    case exam
    
    var collectionName: String {
        switch self {
        case .exam:
            return "Exams"
        case .olymp:
            return "Olymps"
        }
    }
    
    var dashboardTitle: String {
        switch self {
        case .exam:
            return "ЕГЭ"
        case .olymp:
            return "Олимпиада"
        }
    }
}

typealias InitialLessonOutputList = [InitialLessonOutput]

struct InitialLessonOutput {
    let id: String
    let name: String
    let iconUrl: URL
}

protocol ILessonsRepository {
    func fetchInitialLessons(by type: InitialLessonType, completion: @escaping (Result<InitialLessonOutputList, Error>) -> Void)
    func fetchLessonsList(initialLessonType: InitialLessonType, type: LessonType, id: String, completion: @escaping (Result<LessonsListOutput, Error>) -> Void)
    func getNews(completion: @escaping (Result<NewsListModel, Error>) -> Void)
}

final class LessonsRepositoryImpl {
    let db = Firestore.firestore()
}

extension LessonsRepositoryImpl: ILessonsRepository {
    func fetchInitialLessons(by type: InitialLessonType, completion: @escaping (Result<InitialLessonOutputList, Error>) -> Void) {
        
        db.collection(type.collectionName).getDocuments { querySnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            if let querySnapshot {
                var response: [InitialLessonOutput] = []
                
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let id = document.documentID
                    let name = data["name"] as? String ?? "Error"
                    let icon = data["iconUrl"] as? String ?? ""
                    let iconUrl = URL(string: icon)!
                    
                    let model = InitialLessonOutput(id: id, name: name, iconUrl: iconUrl)
                    response.append(model)
                }
                
                completion(.success(response))
            }
        }
    }
    
    func fetchLessonsList(initialLessonType: InitialLessonType, type: LessonType, id: String, completion: @escaping (Result<LessonsListOutput, Error>) -> Void) {
        db.collection("/\(initialLessonType.collectionName)/\(id)/\(type.collectionName)").getDocuments { querySnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            if let querySnapshot {
                var response: LessonsListOutput = []
                
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let id = document.documentID
                    let name = data["name"] as? String ?? "Error"
                    let hardness = data["hardness"] as? Hardness ?? .low
                    let description = data["description"] as? String ?? "Error"
                    let pdfString = data["pdf"] as? String ?? "Error"
                    let pdfUrl = URL(string: pdfString)!
                    let iconUrl = data["iconUrl"] as? String
                    
                    let model = LessonOutput(documentId: id, hardness: hardness, name: name, description: description, pdf: pdfUrl, iconUrl: iconUrl)
                    response.append(model)
                }
                
                completion(.success(response))
            }
        }
    }
    
    func getNews(completion: @escaping (Result<NewsListModel, Error>) -> Void) {
        db.collection("News").getDocuments { q, e in
            if let e {
                completion(.failure(e))
            }
            
            if let q {
                var response: NewsListModel = []
                
                for document in q.documents {
                    let data = document.data()
                    
                    let id = document.documentID
                    let title = data["title"] as! String
                    let description = data["description"] as! String
                    let time = data["time"] as! String
                    let image = data["image"] as! String
                    let imageUrl = URL(string: image)!
 
                    let model: NewsModel = .init(title: title, description: description, time: time, imageUrl: imageUrl)
                    response.append(model)
                }
                
                completion(.success(response))
            }
        }
    }
    
    func fetchOlympYearList(initialLessonType: InitialLessonType, id: String, type: LessonType, completion: @escaping (Result<[OlympModel], Error>) -> Void) {
        db.collection("/\(initialLessonType.collectionName)/\(id)/\(type.collectionName)").getDocuments { querySnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            if let querySnapshot {
                var response: [OlympModel] = []
                
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let id = document.documentID
                    let year = data["year"] as? String ?? "Error"
                    let description = data["description"] as? String ?? "Error"
                    let pdfString = data["pdf"] as? String ?? "Error"
                    let final = data["final"] as? String ?? "Error"
                    let selective = data["selective"] as? String ?? "Error"
                    let pdfUrl = URL(string: pdfString)!
                    let finalURL = URL(string: pdfString)!
                    let selectiveURL = URL(string: pdfString)!
                    
                    let model = OlympModel(year: year, description: description, pdf: pdfUrl, final: finalURL, selective: selectiveURL)
                    response.append(model)
                }
                
                completion(.success(response))
            }
        }
    }
}

struct OlympModel: Codable {
    let year: String?
    let description: String?
    let pdf: URL?
    let final: URL?
    let selective: URL?
}
