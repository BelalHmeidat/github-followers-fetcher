//
//  ViewController.swift
//  github-followers-fetcher
//
//  Created by Belal Hmeidat on 10/17/23.
//

import UIKit

class UserLookupViewController: UIViewController {
    
    //MARK: ViewModel Instance
    private let viewModel = UserLookupViewModel()
    
    //MARK: Outlets
    @IBOutlet weak private var usernameTextfield: UITextField!
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var submitButton: UIButton!
    
    //MARK: On start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfield()
        submitButton.isEnabled = false
    }
    
    private func setupTextfield() {
        setupTextfieldBorder()
        usernameTextfield.placeholder = viewModel.placeholderUsername
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
    
    private func showAlert(_ error: String?) {
        let alert = UIAlertController(title: "Invalid Username!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    private func sendRequest() {
        loadingIndicator.startAnimating()
        viewModel.findUser(username: usernameTextfield.text!) { [weak self] errorMessage in
            if let errorMessage = errorMessage{
                DispatchQueue.main.async(execute: {
                    self?.loadingIndicator.stopAnimating()
                    self?.showAlert(errorMessage)
                })
            }
            else {
                self?.presentUserProfileViewController()
            }
            DispatchQueue.main.async(execute: {
                self?.submitButton.isEnabled = true
                self?.loadingIndicator.stopAnimating()
            })
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
        }
    }
    
    func presentUserProfileViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "showDetail") as! UINavigationController
        //accessing the top view controller of the UINavigationController
        let destinationVC = destination.topViewController as! UserProfileViewController
        // Passing data to destination view model
        destinationVC.viewModel = viewModel.userDetail
        self.present(destination, animated: true)
    }
    
   //MARK: Outlet Functions
    @IBAction private func submitButtonPressed(_ sender: UIButton) {
        submitButton.isEnabled = false
        let usernameVerification = viewModel.verifyUsernameValid(usernameText: usernameTextfield.text!)
        if (usernameVerification != nil){
            showAlert(usernameVerification)
        }
        else {
            sendRequest()
        }
    }
    
    @IBAction private func textfieldPrimaryAction(_ sender: UITextField) {
        submitButtonPressed(submitButton)
        usernameTextfield.endEditing(true)
    }
}
extension UserLookupViewController: UITextFieldDelegate {
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
}
  
