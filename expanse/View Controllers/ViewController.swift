//
//  ViewController.swift
//  expanse
//
//  Created by Vinicius Alencar on 07/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        hideKeyboardWhenTappedAround()
    }
    
    func setupElements() {
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 1, green: 0.6358063221, blue: 0, alpha: 1)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
    }
    @IBAction func loginTapped(_ sender: UIButton) {
    }
    
    


}


