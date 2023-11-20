//
//  FollowersCollectionViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/9/23.
//

import Foundation

class FollowersCollectionViewModel {
    var userProfileName: String?
    var followers: [Follower] = []
    
    init(userProfileName: String?) {
        self.userProfileName = userProfileName
    }
    
    func getFollowerList(username: String){
        let followersList: [Follower] = []
        //TODO: get from API
        
        followers = followersList
    }
}
