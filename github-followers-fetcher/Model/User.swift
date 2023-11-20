//
//  User.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/30/23.
//

import Foundation

class User {
    var username : String
    var description : String
    var profileImageUrl : String
    
    init(name : String, description : String, profileImage: String){
        self.username = name
        self.profileImageUrl = profileImage
        self.description = description
    }
}
