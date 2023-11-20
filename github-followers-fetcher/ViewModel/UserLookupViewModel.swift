//
//  UserLookupViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/26/23.
//

import Foundation
import UIKit

class UserLookupViewModel {
    //MARK: Singleton
    static let shared = UserLookupViewModel()
    
    //MARK: Models
    let apiService = FollowersAPI()
    var userDetail : UserProfileViewModel?
    
    //MARK: properties
    private(set) var placeholderUsername : String = "Type in a username to lookup"
    
    var errorMessage : String? //taken from the API
    
    var userData : [String : Any]?

    //MARK: initilizer
    private init(){}
    
    //MARK: functions
    func verifyUsernameValid(usernameText : String)->String?{
        if (!UsernameVerification.isUsernameValid(username: usernameText)){
            return "Username has to consist of alphanumric characters only!"
        }
        return nil
    }
//    TODO: Get tid of the properties and use completion handler
    func connectToAPI(username : String) async {
        errorMessage = nil
        userData = nil
        let url = URL(string : "https://api.github.com/users/\(username)")
        Task{
            await apiService.excuteRequest(url: url!) {(responeDict, error) in
                if (error != nil){
                    self.errorMessage = error!.localizedDescription
                }
                else {
                    self.userData = responeDict!
                    self.errorMessage = responeDict!["message"] as? String
                    self.passData()
                }
            }
        }
    }
    private func passData() {
        apiService.downloadImage(from: URL(string: userData!["avatar_url"] as! String)!) {[weak self] image in
            let profileImage = image
            self?.userDetail = UserProfileViewModel(name: self?.userData!["name"] as? String ?? "", followersCount: self?.userData!["followers"] as! Int, bio: self?.userData!["bio"] as? String ?? "", image: profileImage)
        }

    }
}
