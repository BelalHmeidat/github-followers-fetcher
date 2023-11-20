//
//  FollowersCollectionViewController.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/9/23.
//

import UIKit

class FollowersCollectionViewController: UIViewController {

    @IBOutlet weak var collectionVIew: UICollectionView!
    override func viewDidLoad() {
        self.title = "Followers"
        super.viewDidLoad()
    }
    

    @IBAction private func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension UserProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.indentifier, for: indexPath as IndexPath)
        return cell
    }
}
    
