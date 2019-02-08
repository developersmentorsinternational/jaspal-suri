//
//  LoginViewController.swift
//  Mentors International
//
//  Created by Jaspal on 2/4/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var emailSignInTextField: UITextField!
    @IBOutlet weak var passwordSignInTextField: UITextField!
    
    @IBAction func signInButton(_ sender: Any) {
        
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        print("Sign up button tapped.")
        
     //   let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
    }
    

    
}
