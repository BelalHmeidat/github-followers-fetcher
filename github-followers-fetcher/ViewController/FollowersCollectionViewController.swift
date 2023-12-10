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
    @IBOutlet weak var navigationBar: UINavigationBar! //needed to remove the border line
    
    //MARK: ViewModel
    var viewModel: FollowersCollectionViewModel?
    
    //MARK: Initilizing View
    private func setupGridLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 80, height: 150)
        collectionView.collectionViewLayout = layout
    }
    
    private func removeNavBarOutline() {
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Followers"
        setupGridLayout()
        removeNavBarOutline()
//        searchBar.backgroundImage = UIImage() /// trick to removesthe lines above and below the search bar
        viewModel?.filteredFollowerCells = viewModel!.followerCells /// initizlizes the followers list to be viewed
    }
    
    //MARK: Outlet Actions
    @IBAction private func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension FollowersCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.filteredFollowerCells.count) ?? 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.indentifier, for: indexPath as IndexPath) as! FollowerCollectionViewCell
        if viewModel?.followerCells.count != 0 {
            let cellModel = viewModel!.filteredFollowerCells[indexPath.row]
            cell.setup(configure: cellModel)
            return cell
        }
        return FollowerCollectionViewCell()
    }
}

extension FollowersCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterFollowers(text: searchText.lowercased())
        collectionView.reloadData()
    }
}
    
