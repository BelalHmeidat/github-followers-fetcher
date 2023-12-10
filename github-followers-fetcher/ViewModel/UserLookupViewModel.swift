//
//  UserLookupViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/26/23.
//

import Foundation
import UIKit

class UserLookupViewModel {
    
    //MARK: Models
    let apiService = FollowersAPI()
    var userDetail: UserProfileViewModel?
    
    //MARK: properties
    private(set) var placeholderUsername: String = "Type in a username to lookup"
    
    //MARK: initilizer
    init(){}
    
    //MARK: functions
    func verifyUsernameValid(usernameText: String)->String?{
        if (!UsernameVerification.isUsernameValid(username: usernameText)){
            return "Username has to consist of alphanumric characters only!"
        }
        return nil
    }
    
    func findUser(username: String, completion: @escaping (String?)->()) {
        let url = URL(string: "https://api.github.com/users/\(username)")
            apiService.requestUser(url: url!) {(responeDict, error) in
                if let errorMessage = error{
                    completion(errorMessage.localizedDescription)
                }
                else if let err = responeDict!["message"] as? String {
                    completion(err)
                }
                else {
                    let user = User(id: responeDict!["id"] as! Int, name: responeDict!["name"] as? String ?? "",
                                    follows: responeDict!["followers"] as! Int,
                                     bio: responeDict!["bio"] as? String ?? "",
                                     avatarURL: responeDict!["avatar_url"] as? String ?? "")
                    self.userDetail = nil
                    self.getUserAvatar(imageUrl: user.avatarURL) { profileImage in
                        self.userDetail = UserProfileViewModel(username: username, name: (user.name!), followersCount: (user.follows!), bio: (user.bio!), image: (profileImage))
                        completion(nil)
                    }
                }
            }
    }
    
    private func getUserAvatar(imageUrl: String, completion: @escaping (UIImage)->()){
        FollowersAPI.downloadImage(from: URL(string: imageUrl)!) {image in
            completion(image)
        }
    }
}
