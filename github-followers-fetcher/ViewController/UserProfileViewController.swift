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
    
    //MARK: Initializng
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Outlets functions
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
            return 300
        }
//        else if viewModel?.tableUIModelList[indexPath.row] is UserTableUIModel{
//            return 200
//        }
        return 200
    }
    
}
