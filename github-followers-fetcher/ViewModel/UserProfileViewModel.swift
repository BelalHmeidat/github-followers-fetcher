//
//  UserProfileModelView.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/6/23.
//

import Foundation

class UserProfileViewModel {
    var followersList: [User] = []
    
    var tableUIModelList: [TableUIModel] = []
    var username: String?
    
    //    MARK: constructor
    init(username: String, name: String, followersCount: Int, bio: String, imageURL: String) {
        tableUIModelList.removeAll()
        tableUIModelList.append(UserImageTableUIModel(/*profilePic: image,*/ avatarURL: imageURL))
        tableUIModelList.append(UserTableUIModel(name: name, followersCount: followersCount, bio: bio))
        self.username = username
    }
    
    func findFollower(username: String, completion: @escaping (String?)->()) {
        FollowersAPI.fetchFollower(username: username) {
            (FollowerList: [User]?, errorMessage) in
            if let FollowerList = FollowerList {
                self.followersList = FollowerList
                completion(nil)
            }
            else {
                completion(errorMessage)
            }
        }
    }
    
}
