//
//  ProfileViewController.swift
//  Mentors International
//
//  Created by Jaspal on 2/4/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        print("Sign out button tapped")
        KeychainWrapper.standard.removeObject(forKey: "cookie")
        KeychainWrapper.standard.removeObject(forKey: "id")
        
        // Take the user back to the sign in page.
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
    }
    
    @IBAction func loadMemberProfileButton(_ sender: Any) {
        print("Load member profile.")
        loadMemberProfile()
    }
    
    func loadMemberProfile() {
        let cookie: String? = KeychainWrapper.standard.string(forKey: "cookie")
        let userID: String? = KeychainWrapper.standard.string(forKey: "id")
        
        // Send HTTP Request to perform Sign in
        let myURL = URL(string: "https://mentors-international.herokuapp.com/api/user/\(userID!)")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(cookie!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    // replace "userId" with something else
                    // should be "id"
                    let userID = parseJSON["id"] as? String
                    print("User id: \(String(describing: userID!))")
                    
                    if (userID?.isEmpty)! {
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                        return
                    } else {
                        self.displayMessage(userMessage: "Successfully registered a new account. Please sign in!")
                    }
                    
                } else {
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                }
            } catch {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print(error)
            }
        }
        task.resume()
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
    
    
    @IBOutlet weak var mentorFullNameLabel: UILabel!

}
