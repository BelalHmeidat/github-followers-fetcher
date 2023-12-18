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
    
    func findUser(username: String, completion: @escaping ((String?, String?))->()){
        let url = URL(string: "https://api.github.com/users/\(username)")!
//        let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(nilEncoding: .dropKey))
        AF.request(url).validate().responseDecodable(of: User.self) { response in
            switch (response.result) {
                case .success(let data):
                    self.userDetail = nil
                    self.getUserAvatar(imageUrl: data.avatarURL) { profileImage in
                        self.userDetail = UserProfileViewModel(username: username, name: (data.name ?? "" ), followersCount: (data.follows!), bio: (data.bio ?? ""), image: (profileImage))
                        completion((nil, nil))
                    }
                case .failure(let error):
                    if let statusCode = error.responseCode {
                        switch (statusCode) {
                        case 404:
                            completion(("Invalid Username!", "User not Found!"))
                        default:
                            completion(("Error", response.error?.errorDescription!))
                        }
                    }
                    else {
                        completion(("Error", error.localizedDescription))
                    }
            }
        }
    }
    
    private func getUserAvatar(imageUrl: String, completion: @escaping (UIImage)->()){
        FollowersAPI.downloadImage(url: URL(string: imageUrl)!) {image in
            completion(image)
        }
    }
}
