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
        KeychainWrapper.standard.removeObject(forKey: "token")
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
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        let userID: String? = KeychainWrapper.standard.string(forKey: "id")
        
        // Send HTTP Request to perform Sign in
        let myURL = URL(string: "https://mentors-international.herokuapp.com/api/user/\(userID!)")
        var request = URLRequest(url: myURL!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print("error=\(String(describing: error))")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    DispatchQueue.main.async {
                        let firstName: String? = parseJSON["firstName"] as? String
                        let lastName: String? = parseJSON["lastName"] as? String
                        
                        if firstName?.isEmpty != true && lastName?.isEmpty != true {
                            self.mentorFullNameLabel.text = "\(firstName!) \(lastName!)"
                        }
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
