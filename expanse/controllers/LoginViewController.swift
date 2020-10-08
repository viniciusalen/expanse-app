//
//  LoginViewController.swift
//  expanse
//
//  Created by Vinicius Alencar on 07/10/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        hideKeyboardWhenTappedAround()
    }
    
    func setUpElements(){
        
        //hide the error label
        errorLabel.alpha = 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: UIButton) {
        
        //validate the fields
        
        let error = validateFields()
        
        if error != nil {
            // There`s something wrong with the fields, show error message
            showError(error!)
            
        }else{
            // create a cleanud
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    // couldnt sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }else{
                    self.transitionToTabBarVC()
                }
            }
        }
        
        
    }
    
    func transitionToTabBarVC() {
        self.performSegue(withIdentifier: "goToTabBarVC", sender: self)
        
    }
    
    func validateFields() -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "\n\n Please fill in all fields"
        }
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}




