//
//  UserLookupViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/26/23.
//

import Foundation
import UIKit
import Alamofire

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
    
    func findUser(username: String, completion: @escaping (String?)->()){
        
        //        AF.request(url).validate().responseDecodable(of: User.self) { response in
        //            switch (response.result) {
        //                case .success(let data):
        //                    self.userDetail = nil
        //                    self.getUserAvatar(imageUrl: data.avatarURL) { profileImage in
        //                        self.userDetail = UserProfileViewModel(username: username, name: (data.name ?? "" ), followersCount: (data.follows!), bio: (data.bio ?? ""), image: (profileImage))
        //                        completion((nil, nil))
        //                    }
        //                case .failure(let error):
        //                    if let statusCode = error.responseCode {
        //                        switch (statusCode) {
        //                        case 404:
        //                            completion(("Invalid Username!", "User not Found!"))
        //                        default:
        //                            completion(("Error", response.error?.errorDescription!))
        //                        }
        //                    }
        //                    else {
        //                        completion(("Error", error.localizedDescription))
        //                    }
        //            }
        //        }
        //    }
        FollowersAPI.fetchUserProfile(username: username) { (user: User?, errorMessage) in
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
    
//    private func getUserAvatar(imageUrl: String, completion: @escaping (UIImage)->()){
//        FollowersAPI.downloadImage(url: URL(string: imageUrl)!) {image in
//            completion(image)
//        }
//    }
}
