//
//  ViewController.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/17/23.
//

import UIKit

class UserLookupViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: ViewModel Instance
    private let viewModel = UserLookupViewModel.shared
    
    //MARK: Outlets
    @IBOutlet weak private var usernameTextfield: UITextField!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var submitButton: UIButton!
    
    //MARK: On start
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextfield.delegate = self
        setupTextfieldBorder()
        usernameTextfield.placeholder = viewModel.placeholderUsername
        submitButton.isEnabled = false
    }
    
    //MARK: Functions
    private func setupTextfieldBorder(){
        usernameTextfield.clipsToBounds = true ///Needed for the rounded corners
        usernameTextfield.layer.cornerRadius = usernameTextfield.bounds.height/2
        usernameTextfield.layer.borderWidth = 1
        usernameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        func addPaddingToTextfield() {
            let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.usernameTextfield.frame.height))
            usernameTextfield.leftView = paddingView
            usernameTextfield.leftViewMode = UITextField.ViewMode.always
            usernameTextfield.rightView = paddingView
            usernameTextfield.rightViewMode = UITextField.ViewMode.always
        }
        addPaddingToTextfield()
    }
    func textField(_ usernameTextfield: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let currentText = usernameTextfield.text ?? ""
          let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if (updatedText.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            submitButton.isEnabled = false
        }
        else {
            submitButton.isEnabled = true
        }
          return true
      }
    
    private func showAlert(_ error: String?) {
        let alert = UIAlertController(title: "Invalid Username!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    private func sendRequest() async {
            await viewModel.connectToAPI(username: usernameTextfield.text!)
            do {
                loadingIndicator.startAnimating()
               try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
                loadingIndicator.stopAnimating()
            }
            catch{}
            let errorMessage = viewModel.errorMessage
            if (errorMessage != nil){
                showAlert(errorMessage)
                return
            }
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserDetail" {
            if let destination = segue.destination as? UINavigationController {
                //accessing the top view controller of the UINavigationController
                let destinationVC = destination.topViewController as! UserProfileViewController
                // Passing data to destination view model
                destinationVC.viewModel = viewModel.userDetail
            }
//            if let destinationVC = segue.destination as? UserProfileViewController {
//                destinationVC.viewModel = viewModel.passData()
//            }
        }
    }
    
   //MARK: Outlet Functions
    @IBAction private func submitButtonPressed(_ sender: UIButton) {
        submitButton.isEnabled = false
        Task {
            let usernameVerification = viewModel.verifyUsernameValid(usernameText: usernameTextfield.text!)
            if (usernameVerification != nil){
                showAlert(usernameVerification)
            }
            else {
                await sendRequest()
                submitButton.isEnabled = true
            }
            if (viewModel.errorMessage == nil){
                performSegue(withIdentifier: "ShowUserDetail", sender: self)
            }
//            print(viewModel.userData!)
        }
    }
    
    @IBAction private func textfieldPrimaryAction(_ sender: UITextField) {
        submitButtonPressed(submitButton)
        usernameTextfield.endEditing(true)
    }
}



