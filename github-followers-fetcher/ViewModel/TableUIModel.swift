//
//  CellViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/23/23.
//

import UIKit
class TableUIModel {
    
}

class UserTableUIModel: TableUIModel {
    var name: String?
    var followersCount: Int?
    var bio: String?
    
    init(name : String, followersCount : Int, bio : String){
        self.name = name
        self.followersCount = followersCount
        self.bio = bio
    }
}

class UserImageTableUIModel: TableUIModel {
//    var profilePic: UIImage?
    var avatarURL: String
    init(/*profilePic: UIImage?, */avatarURL: String) {
//        self.profilePic = profilePic
        self.avatarURL = avatarURL
    }
}
