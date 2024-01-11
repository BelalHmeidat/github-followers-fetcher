//
//  NetworkingManger.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 12/20/23.
//

import Foundation
import Alamofire

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init(){}
    
    private let session = Session(configuration: URLSessionConfiguration.af.default)
       
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
    
    func excuteRequest<T: Decodable>(routerCase: FollowersRouter,  completion: @escaping (T?, String?) -> Void){
        session.request(routerCase).validate().responseDecodable(of: T.self) { response in
            switch (response.result) {
            case .success(let data):
                completion(data, nil)
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
    }
}

