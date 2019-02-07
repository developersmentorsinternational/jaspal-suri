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
        print("Sign in button tapped.")
        
        // Text field values
        let userName = emailSignInTextField.text
        let userPassword = passwordSignInTextField.text
        
        // Check if fields are empty
        if (userName?.isEmpty)! || (userPassword?.isEmpty)! {
            // Alert message
            print("Username \(String(describing: userName)) or password \(String(describing: userPassword)) is empty")
            displayMessage(userMessage: "One of the required fields is missing")
            
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
        
        // Send HTTP Request to perform Sign in
        let myURL = URL(string: "https://mentors-international.herokuapp.com/login")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "POST" // Compose a query string
        request.addValue("application/json", forHTTPHeaderField:  "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["email": userName!, "password": userPassword!] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Was not able to send the data for registration, sorry.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response: URLResponse?, error) in
//            guard let httpResponse = response as? HTTPURLResponse,
//                let responseURL = response?.url else { return }
//            let cookies = HTTPCookie.cookies(withResponseHeaderFields: httpResponse.allHeaderFields as! [String : String], for: responseURL)
//            setCookie(cookie: cookies)
            
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
                    // the word cookie was used in place of "token" and "accessToken" string
                    
//                    guard let httpResponse = response as? HTTPURLResponse,
//                        let responseURL = response?.url else { return }
//                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: httpResponse.allHeaderFields as! [String : String], for: responseURL)
//                    setCookie(cookie: cookies)
                    
                    let token = parseJSON["token"] as? String
                    let userID = parseJSON["id"] as? String
                    print("Token: \(String(describing: token!))")
                    
                    let saveToken: Bool = KeychainWrapper.standard.set(token!, forKey: "token")
                    let saveUserID: Bool = KeychainWrapper.standard.set(userID!, forKey: "id")
                    
                    // Debug test for Keychain
                    print("The token save result: \(saveToken)")
                    print("The userID save result: \(saveUserID)")
                    
                    if (token?.isEmpty)! {
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let profilePage = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = profilePage
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
    
    
    @IBAction func signUpButton(_ sender: Any) {
        print("Sign up button tapped.")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
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
