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
        nameLabel.text = configure.name!
        let followersAttribute = [ NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedFollowersCount = NSAttributedString(string: String(configure.followersCount!), attributes: followersAttribute)
        let followersLabelText = NSMutableAttributedString(string: "\(configure.name!) has ")
        followersLabelText.append(attributedFollowersCount)
        followersLabelText.append(NSAttributedString(string:" followers"))
        followerCountLabel.attributedText = followersLabelText
        bioLabel.text = configure.bio
    }
}

class UserImageTableViewCell: UITableViewCell {
    static let identifier = "UserImageTableViewCell"
    
    //MARK: Outlets
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func makeRounded(imageView: UIImageView) {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius =  userImageView.layer.frame.height/2//image.frame.size.width / 2
        imageView.clipsToBounds = true
    }
    
    func setup(configure: UserImageTableUIModel){
        NetworkManager.shared.getUserAvatar(imageUrl: configure.avatarURL) {
            profileImage in self.userImageView.image = profileImage
        }
        makeRounded(imageView: userImageView)
    }
}


