//
//  RegisterViewController.swift
//  Mentors International
//
//  Created by Jaspal on 2/4/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    let controller = Controller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    // this will be country
    // change from numeric to alphabetical
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    // this will be type
    @IBOutlet weak var regionTextField: UITextField!
    
    // Switch to login page
    @IBAction func signInRegisterButton(_ sender: Any) {
    }
    
    @IBAction func signUpRegisterButton(_ sender: Any) {
        let regionInt = Int(regionTextField.text!)
        let user = User(email: emailTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, country: countryCodeTextField.text!, type: "MENTOR", region: regionInt!)
        controller.register(user: user) { (error, token) in
            DispatchQueue.main.async {
                // Display errors regarding registering users with similar usernames
                self.controller.sessionToken = token
            let transitionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController")
                transitionVC.view.frame = UIScreen.main.bounds
                self.present(transitionVC, animated: true)
            }
        }
    }
}
