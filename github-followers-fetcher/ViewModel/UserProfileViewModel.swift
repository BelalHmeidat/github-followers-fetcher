//
//  UserProfileModelView.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/6/23.
//

import Foundation
import UIKit

class UserProfileViewModel {
    
    var tableUIModelList: [TableUIModel] = []
        
//    MARK: constructor
    init(name: String, followersCount: Int, bio: String, image: UIImage) {
        buildUIModel(name: name, followersCount: followersCount, bio: bio, image: image)
    }
    
    func buildUIModel(name: String, followersCount: Int, bio: String, image: UIImage){
        tableUIModelList.append(UserImageTableUIModel(profilePic: image))
        tableUIModelList.append(UserTableUIModel(name: name, followersCount: followersCount, bio: bio))
    }
}
