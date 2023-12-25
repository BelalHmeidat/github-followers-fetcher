import Foundation
import UIKit

enum APIError: String {
    
    case notFound = "User Not Found!"
    case decodingError = "Error while decoding user data!"
    case noConnection = "Error connecting to the server! Make sure you are connected to the internet."
}
    
class FollowersAPI {
    
    static let shared = FollowersAPI()
    
    private init(){}
    
    private func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()){
        var image : UIImage = UIImage(systemName: "person")!
        getImage(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(image)
                return
            }
            // always update the UI from the main thread
            DispatchQueue.main.async() { 
                image = UIImage(data: data)!
                completion(image)
            }
        }
    }
    
//    private func createRequest(url: String) -> URLRequest?{
//        guard let url = URL(string: url) else {return nil}
//        let request = URLRequest(url: url)
//        return request
//    }
    
    func excuteRequest<T: Decodable>(request: URLRequest,  completion: @escaping (T?, String?) -> Void){
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let resp = response as? HTTPURLResponse {
                    if resp.statusCode == 404 {
                        completion(nil, APIError.notFound.rawValue)
                    }
                    else if resp.statusCode == 200 || resp.statusCode == 201 {
                        if let data = data {
                            do {
                                let result = try JSONDecoder().decode(T.self, from: data)
                                completion(result, nil)
                                
                            } catch {
                                completion(nil, APIError.decodingError.rawValue)
                            }
                        }
                    }
                    else {
                        completion(nil, error?.localizedDescription)
                    }
                }
                else {
                    completion(nil, APIError.noConnection.rawValue)
                }
                    return
                } 
        dataTask.resume()
    }
    
}

