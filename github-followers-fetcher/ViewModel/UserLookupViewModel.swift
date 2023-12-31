//
//  UserLookupViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/26/23.
//

import Foundation

class UserLookupViewModel {
    
    //MARK: Models
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
        FollowersAPI.fetchUserProfile(username: username) {
            (user: User?, errorMessage) in
            if let user = user {
                self.userDetail = nil
                self.userDetail = UserProfileViewModel(username: username, name: (user.name!), followersCount: (user.follows!), bio: (user.bio!), imageURL: user.avatarURL)
                completion(nil)
            }
            else {
                completion(errorMessage)
            }
        }
    }
}
