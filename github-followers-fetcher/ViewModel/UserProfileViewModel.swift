//
//  UserProfileModelView.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/6/23.
//

import Foundation
import UIKit

class UserProfileViewModel {
    var apiService: FollowersAPI = FollowersAPI()
    var followersList: [User] = []
    
    var tableUIModelList: [TableUIModel] = []
    var username: String?
    
    //    MARK: constructor
    init(username: String, name: String, followersCount: Int, bio: String, image: UIImage) {
        buildUIModel(name: name, followersCount: followersCount, bio: bio, image: image)
        self.username = username
    }
    
    func buildUIModel(name: String, followersCount: Int, bio: String, image: UIImage){
        tableUIModelList.append(UserImageTableUIModel(profilePic: image))
        tableUIModelList.append(UserTableUIModel(name: name, followersCount: followersCount, bio: bio))
    }
    
    func findFollower(username: String, completion: @escaping (String?)->()) {
        let url = URL(string: "https://api.github.com/users/\(username)/followers")
        apiService.requestFollower(url: url!) {(responeDict, error) in
            if let errorMessage = error{
                completion(errorMessage.localizedDescription)
            }
            else {
                if let followersResponse = responeDict {
                    self.followersList = [] /// resolves duplicates
                    for user in followersResponse {
                        let follower = User(id: user["id"] as! Int, username: user["login"] as! String, avatarURL: user["avatar_url"] as! String)
                        self.followersList.append(follower)
                    }
                }
                completion(nil)
            }
        }
    }
    
}
