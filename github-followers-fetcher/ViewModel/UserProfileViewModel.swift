//
//  UserProfileModelView.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/6/23.
//

import Foundation
import UIKit
import Alamofire

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
        AF.request(url!).validate().responseDecodable(of: [User].self) { response in
            switch (response.result) {
                case .success(let data):
                    self.followersList = data
                    completion(nil)
                
                case .failure(let error):
                    if let statusCode = error.responseCode {
                        switch (statusCode) {
                        case 404:
                            completion(error.localizedDescription)
                            
                        default:
                            completion(error.localizedDescription)
                        }
                    }
                    else {
                        completion(error.localizedDescription)
                    }
            }
        }
    }
}
