//
//  SingUpViewController.swift
//  expanse
//
//  Created by Vinicius Alencar on 07/10/20.
//

import UIKit
import Firebase
import FirebaseAuth

class SingUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        hideKeyboardWhenTappedAround()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
    }

  
    func validateFields() -> String? {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "\n\n please fill in all fields"
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password isnt secure enought
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        return nil
    }
    
    
    
    @IBAction func singUpTapped(_ sender: UIButton) {
        
        
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            // There`s something wrong with the fields, show error message
            showError(error!)
        }else{
            
            // create cleaned versions of the data
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the users
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // check for errors
                if err != nil {
                    // there was an error creating user
                    self.showError("\n\nError creating user\n\n")
                }else{
                    // User was created successfully
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            //show error message
                            self.showError("\n\nError saving user data\n\n")
                        }
                    }
                    //transition to the home screen
                    self.transitionToHomeVC()
                     
                }
            }
            
            //transition to the homescreen
        }
        
        
        
        // create the users
        
        //transition to the homescreen
        
    }
    
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHomeVC() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
