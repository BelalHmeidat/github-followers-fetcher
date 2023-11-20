//
//  FollowerCollectionViewCell.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/10/23.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    static var indentifier : String = "FollowerCollectionViewCell"
    
    @IBOutlet weak var followerImage: UIImageView!
    @IBOutlet weak var followerName: UILabel!
    
    func setup(configure : FollowerCellViewModel){
        followerImage.image = configure.image
        followerName.text = configure.name
    }
    
}
