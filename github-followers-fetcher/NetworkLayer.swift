import Foundation
import UIKit


class FollowersAPI {
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
    
    func excuteRequest(url: URL, completionHandler: @escaping ([String: Any]?, Error?)->Void) async{
        let sharedSession = URLSession.shared
        let webRequest = URLRequest(url: url)
        
        let dataTask = sharedSession.dataTask(with: webRequest) { (webData, urlResponse, apiError) in
            guard let unwarppedData = webData else {
                completionHandler(nil, apiError)
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: unwarppedData, options: .mutableContainers) as? [String:Any]
                completionHandler(jsonResponse, nil)
            }
            catch{
                print(error.localizedDescription)
                completionHandler(nil, error)
            }
        }
        dataTask.resume()
    }
}

