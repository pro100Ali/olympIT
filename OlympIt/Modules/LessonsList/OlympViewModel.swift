import Foundation
import FirebaseFirestore

protocol OlympRepository {
    func getOlymp(lessonId: String, olympId: String, completion: @escaping (Result<[OlympModel], Error>) -> Void)
}

final class OlympRepositoryImpl {
    let db = Firestore.firestore()
    
    func getOlymp(lessonId: String, olympId: String, completion: @escaping (Result<[OlympModel], Error>) -> Void) {
        db.collection("/\(InitialLessonType.olymp.collectionName)/\(lessonId)/\(LessonType.practice.collectionName)/\(olympId)/\("Olimpiades")").getDocuments { querySnapshot, error in
            if let error {
                completion(.failure(error))
            }
            
            if let querySnapshot {
                var response: [OlympModel] = []
                
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let id = document.documentID
                    let year = data["year"] as? String ?? "Error"
                    let description = data["description"] as? String
                    let pdfString = data["pdf"] as? String ?? "Error"
                    let final = data["final"] as? String ?? "Error"
                    let selective = data["selective"] as? String ?? "Error"
                    let pdfUrl = URL(string: pdfString)!
                    let finalURL = URL(string: final)!
                    let selectiveURL = URL(string: selective)!
                    
                    let model = OlympModel(year: year, description: description, pdf: pdfUrl, final: finalURL, selective: selectiveURL)
                    response.append(model)
                }
                
                completion(.success(response))
            }
        }
    }
}

class OlympViewModel {
    let lessonId: String
    let olympId: String
    let repository: OlympRepositoryImpl = OlympRepositoryImpl()
    var lessons: [OlympModel] = []
    
    var filteredData: [OlympModel] = [] {
        didSet {
            completion()
        }
    }
    
    var completion: () -> () = {}
    
    init(lessonId: String, olympId: String) {
        self.lessonId = lessonId
        self.olympId = olympId
    }
    
    func getOlymp() {
        repository.getOlymp(lessonId: lessonId, olympId: olympId) { res in
            switch res {
            case .success(let success):
                self.lessons = success
                self.filteredData = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
