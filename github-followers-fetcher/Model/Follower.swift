//
//  Follower.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/10/23.
//

import Foundation
import UIKit

class Follower {
    var name : String?
    var picture : UIImage?
    
    init(name: String? = nil, picture: UIImage? = nil) {
        self.name = name
        self.picture = picture
    }
}
