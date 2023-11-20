//
//  UserDetailCell.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/6/23.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {
    static let identifier  = "UserDetailTableViewCell"
    
    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Filling the cell
    func setup(configure: UserTableUIModel){
        nameLabel.text = configure.name
        followerCountLabel.text = "\(configure.name!) has \(configure.followersCount!) followers"
        bioLabel.text = configure.bio
    }
}

class UserImageTableViewCell: UITableViewCell {
    static let identifier = "UserImageTableViewCell"
    
    //MARK: Outlets
    
    @IBOutlet weak var userProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(configure: UserImageTableUIModel){
        userProfile.image = configure.profilePic
    }
}

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
    var profilePic: UIImage?
    init(profilePic: UIImage?) {
        self.profilePic = profilePic
    }
}


