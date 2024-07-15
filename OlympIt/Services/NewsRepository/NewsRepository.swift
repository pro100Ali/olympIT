import FirebaseFirestore

protocol NewsRepository {
    func getNews(completion: @escaping (Result<NewsListModel, Error>) -> Void)
}

final class NewsRepositoryImpl {
    let db = Firestore.firestore()
}

extension NewsRepositoryImpl: NewsRepository {
    
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
}
