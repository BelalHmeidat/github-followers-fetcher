//
//  FollowersAPI.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 12/25/23.
//

import Foundation

class FollowersAPI{
        
    static func fetchUserProfile(username: String, completion: @escaping (User?, String?)->()){
        let request = Endpoints.getUser(user: username).request!
        NetworkingManager.shared.excuteRequest(request: request) {
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
    
    static func fetchFollower(username: String, completion: @escaping ([User]?, String?)->()){
        let request = Endpoints.getFollowerList(user: username).request!
        NetworkingManager.shared.excuteRequest(request: request) {
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
    
    static func getUserAvatarData(imageURL: String, completion: @escaping (_ imageData: Data?, _ errorMessage: String?) -> ()) {
        NetworkingManager.shared.getImage(from: URL(string: imageURL)!) { data, response, error  in
            guard let data = data, error == nil else {
                completion(nil, error?.localizedDescription)
                return
            }
            completion(data, nil)
        }
    }
}
