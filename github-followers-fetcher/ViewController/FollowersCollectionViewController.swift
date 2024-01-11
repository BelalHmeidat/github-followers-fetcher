//
//  FollowersCollectionViewController.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/9/23.
//

import UIKit

class FollowersCollectionViewController: UIViewController {
   
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: ViewModel
    var viewModel: FollowersCollectionViewModel?
    
    //MARK: Initilizing View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Followers"
//        self.navigationItem.backButtonTitle = ""
//        self.navigationController?.navigationBar.navigation.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        self.navigationItem.backBarButtonItem.customMirror.displayStyle =
        self.navigationController?.navigationBar.tintColor = .black
        viewModel?.filteredFollowerCells = viewModel!.followerCells /// initizlizes the followers list to be viewed
    }
}

extension FollowersCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.filteredFollowerCells.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard viewModel?.followerCells.count != 0 else {
            return FollowerCollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.indentifier, for: indexPath as IndexPath) as! FollowerCollectionViewCell
            let cellModel = viewModel!.filteredFollowerCells[indexPath.row]
            cell.setup(configure: cellModel)
            return cell
    }
}

extension FollowersCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterFollowers(text: searchText.lowercased())
        collectionView.reloadData()
    }
}
    
