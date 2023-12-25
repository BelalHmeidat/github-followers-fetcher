//
//  NetwrokManager.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 12/25/23.
//

import Foundation
import UIKit

class NetworkManager{
    
    static var shared = NetworkManager()
    
    private init(){}
    
    func fetchUserProfile(username: String, completion: @escaping (User?, String?)->()){
        let request = Endpoints.getUser(user: username).request!
        FollowersAPI.shared.excuteRequest(request: request) {
            (response: User?, errorMessage) in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
            }
            else {
                if let user = response {
                        completion(user, nil)
                } else {
                    completion(nil, "invalid response")
                    return
                }
            }
        }
        
    }
    
    func fetchFollower(username: String, completion: @escaping ([User]?, String?)->()){
        let request = Endpoints.getFollowerList(user: username).request!
        FollowersAPI.shared.excuteRequest(request: request) {
            (response: [User]?, error) in
            if let errorMessage = error {
                completion(nil, errorMessage)
            }
            else {
                guard let followersList = response else {
                    completion(nil, "invalid response")
                    return
                }
                completion(followersList, nil)
            }
        }
    }
    
    func getUserAvatar(imageUrl: String, completion: @escaping (UIImage)->()){
        FollowersAPI.shared.downloadImage(from: URL(string: imageUrl)!) {image in
            completion(image)
        }
    }
}
