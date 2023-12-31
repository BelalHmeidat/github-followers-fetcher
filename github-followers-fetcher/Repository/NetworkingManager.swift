//
//  NetworkingManger.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 12/20/23.
//

import Foundation
import Alamofire

enum APIError: String {
    case notFound = "User Not Found!"
    case decodingError = "Error while decoding user data!"
    case noConnection = "Error connecting to the server! Make sure you are connected to the internet."
}
    
class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init(){}
    
    func getImage(url: String, completion: @escaping (Data?, String?) -> ()){
        let destination = DownloadRequest.suggestedDownloadDestination(for: .cachesDirectory, options: .removePreviousFile)
        AF.download(
            url,
            to: destination).response(completionHandler: { response in
                do {
                    let imageData = try Data(contentsOf: response.fileURL!)
                    completion(imageData, nil)
                } catch{
                    completion(nil, "error loading asset")
                }
            })
    }
    
    func excuteRequest<T: Decodable>(url: URL, type: String,  completion: @escaping (T?, String?) -> Void){
        switch (type) {
            case "User" :
                AF.request(url).validate().responseDecodable(of: User.self) { response in
                    switch (response.result) {
                    case .success(let data):
                        completion(data as? T, nil)
                    case .failure(let error):
                        if let statusCode = error.responseCode {
                            switch (statusCode) {
                            case 404:
                                completion(nil, "User not Found!")
                            default:
                                completion(nil, response.error?.errorDescription!)
                            }
                        }
                        else {
                            completion(nil, error.localizedDescription)
                        }
                    }
                }
                break
            case "Follower":
                AF.request(url).validate().responseDecodable(of: [User].self) { response in
                    switch (response.result) {
                    case .success(let data):
                        completion(data as? T, nil)
                        
                    case .failure(let error):
                        if let statusCode = error.responseCode {
                            switch (statusCode) {
                            case 404:
                                completion(nil, error.localizedDescription)
                                
                            default:
                                completion(nil, error.localizedDescription)
                            }
                        }
                        else {
                            completion(nil, error.localizedDescription)
                        }
                    }
                }
                break
            default:
                break
        }
    }
    
}

