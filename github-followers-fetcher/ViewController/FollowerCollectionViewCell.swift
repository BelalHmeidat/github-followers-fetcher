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
        getUserAvatar(imageUrl: imageURL , completion: {
            [weak self] image in
            self?.followerImage.image = image
        })
    
    }
    
    private func makeRounded(imageView: UIImageView) {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = followerImage.layer.frame.height/2
        imageView.clipsToBounds = true
    }
    
    private func getUserAvatar(imageUrl: String, completion: @escaping (UIImage)->()){
        FollowersAPI.downloadImage(from: URL(string: imageUrl)!) {image in
            completion(image)
        }
    }
}
