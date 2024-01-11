//
//  UserProfileViewController.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 11/2/23.
//

import UIKit

class UserProfileViewController: UIViewController {
    /// view model instance
    var viewModel: UserProfileViewModel?
    
    //MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    
    //MARK: Initializng
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
//        self.navigationItem.backButtonTitle = ""
//        self.navigationController?.navigationBar.navigation.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonAction))
        self.navigationController?.navigationBar.tintColor = .black
        loadingIndicator.hidesWhenStopped = true
    }
    
    private func presentFollowersViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let followersCollectionViewController = storyboard.instantiateViewController(withIdentifier: "FollowersCollectionViewController") as! FollowersCollectionViewController
        followersCollectionViewController.viewModel = FollowersCollectionViewModel(userProfileName: self.viewModel?.username, followers: (self.viewModel!.followersList))
        self.navigationController?.pushViewController(followersCollectionViewController, animated: true)
    }
    
    private func sendRequest() {
        loadingIndicator.startAnimating()
        viewModel!.findFollower(username: (viewModel?.username)!) { [weak self] errorMessage in
            if let errorMessage = errorMessage{
                DispatchQueue.main.async(execute: {
                    self?.loadingIndicator.stopAnimating()
                    self?.showAlert(errorMessage)
                })
            }
            else {
                DispatchQueue.main.async(execute: {
                    self?.presentFollowersViewController()
                    self?.loadingIndicator.stopAnimating()
                })
            }
        }
    }
    
    private func showAlert(_ error: String?) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    //MARK: Outlets functions
    @IBAction func closeButtonAction(_ sender: UIBarButtonItem) {
        print("click")
//        self.navigationController?.dismiss(animated: true)
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction private func getFollowersButtonPressed(_ sender: UIButton) {
        sendRequest()
    }
}

extension UserProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.tableUIModelList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let userUIModel = viewModel?.tableUIModelList[indexPath.row] as? UserImageTableUIModel, let cell = tableView.dequeueReusableCell(withIdentifier: UserImageTableViewCell.identifier, for: indexPath) as? UserImageTableViewCell {
            cell.setup(configure: userUIModel)
            return cell
        }
        else if let userUIModel = viewModel?.tableUIModelList[indexPath.row] as? UserTableUIModel, let cell = tableView.dequeueReusableCell(withIdentifier : UserDetailTableViewCell.identifier, for: indexPath) as? UserDetailTableViewCell {
            cell.setup(configure: userUIModel)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.tableUIModelList[indexPath.row] is UserImageTableUIModel{
            return 200
        }
//        else if viewModel?.tableUIModelList[indexPath.row] is UserTableUIModel{
//            return 200
//        }
        return 200
    }
    
}
