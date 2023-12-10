//
//  FollowersCollectionViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/9/23.
//

import Foundation

class FollowersCollectionViewModel {
    var followerCells: [CollectionUIModel] = []
    var filteredFollowerCells: [CollectionUIModel] = []
    
    init(userProfileName: String?, followers: [User]) {
        self.followerCells = []
        for follower in followers {
            self.followerCells.append(CollectionUIModel(username: follower.username!, avatarURL: follower.avatarURL))
        }
    }
    
    func filterFollowers(text: String){
        filteredFollowerCells = []
        if (text.isEmpty){
            filteredFollowerCells = followerCells
            return
        }
        for follower in followerCells {
            let followerName = follower.username.lowercased()
            if (followerName.contains(text)){
                filteredFollowerCells.append(follower)
            }
        }
    }
}
