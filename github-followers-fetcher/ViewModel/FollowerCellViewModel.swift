//
//  FollowerCellViewModel.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/10/23.
//

import Foundation
import UIKit

class FollowerCellViewModel {
    var name : String?
    var image : UIImage?
    
    init(name: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.image = image
    }
}
