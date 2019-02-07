//
//  RegisterViewController.swift
//  Mentors International
//
//  Created by Jaspal on 2/4/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    
    @IBAction func signInRegisterButton(_ sender: Any) {
    }
    
    @IBAction func signUpRegisterButton(_ sender: Any) {
        if (firstNameTextField.text?.isEmpty)! ||
            (lastNameTextField.text?.isEmpty)! ||
            (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! ||
            (countryCodeTextField.text?.isEmpty)! ||
            (phoneNumberTextField.text?.isEmpty)! ||
            (regionTextField.text?.isEmpty)!  {
        
        // Display the Alert message and return
        displayMessage(userMessage: "All fields are must be filled in")
        return
        
        }
            
        // Validate password
        if ((passwordTextField.text?.elementsEqual(passwordConfirmationTextField.text!))! != true) {
            
            // Display alert message and return
            displayMessage(userMessage: "The second password does not match the first.")
            return
        }
        
        // Create the Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        
        // Position it in the center of the main view
        myActivityIndicator.center = view.center
        
        // override stopAnimating() if necessary
        myActivityIndicator.hidesWhenStopped = false
        
        // Start and Display the Activity Inidicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        // Send HTTP Request to Register the user
        let myURL = URL(string: "https://mentors-international.herokuapp.com/register")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "POST" // Compose a query string
        request.addValue("application/json", forHTTPHeaderField:  "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = [ "email": emailTextField.text!,
            "firstName": firstNameTextField.text!,
                "lastName": lastNameTextField.text!,
                "password": passwordTextField.text!,
                "countryCode": countryCodeTextField.text!,
                "phoneNumber": phoneNumberTextField.text!
                ] as [ String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Was not able to send the data for registration, sorry.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print("error=\(String(describing: error))")
                return
            }
            
            // Let's convert the response sent from the server-side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    // replace "userId" with something else
                    // should be "id"
                    let userId = parseJSON["userId"] as? String
                    print("User id: \(String(describing: userId!))")
                    
                    if (userId?.isEmpty)! {
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                        return
                    } else {
                        self.displayMessage(userMessage: "Successfully registered a new account. Please sign in!")
                    }
                    
                } else {
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                }
            } catch {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                    print(error)
            }
        }
        task.resume()
    }
    
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }

    
    
    // MARK: Alert function
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped")
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }

        }
        
    }
}
