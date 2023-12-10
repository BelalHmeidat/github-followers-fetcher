//
//  CollectionUIModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 12/7/23.
//

import Foundation

class CollectionUIModel {
    var username: String
    var avatarURL: String
    
    init(username: String, avatarURL: String){
        self.username = username
        self.avatarURL = avatarURL
    }
}
