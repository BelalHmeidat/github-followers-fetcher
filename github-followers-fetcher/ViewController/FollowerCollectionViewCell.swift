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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRounded(imageView: followerImage)
    }
    
    func setup(configure: CollectionUIModel){
        followerName.text = configure.username
        let imageURL = configure.avatarURL
        FollowersAPI.getUserAvatarData(imageURL: imageURL, completion: { [weak self] imageData, errorMessage in
            DispatchQueue.main.async {
                if let imageData = imageData {
                    self?.followerImage.image = UIImage(data: imageData)
                }
                else {
                    self?.followerImage.image = UIImage(systemName: "person")
                }
            }
        })
    }
    
    private func makeRounded(imageView: UIImageView) {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = followerImage.layer.frame.height/2
        imageView.clipsToBounds = true
    }
    
}
