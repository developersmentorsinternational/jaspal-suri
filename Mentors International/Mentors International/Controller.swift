//
//  Controller.swift
//  Mentors International
//
//  Created by Jaspal on 2/7/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import Foundation

class Controller {
    
    var baseURL = URL(string: "https://mentors-international.herokuapp.com/")!
    
    // User is logged in
    var sessionToken: Token?
    
    func register(user: User, completion: @escaping (Error?, Token?) -> Void) {
        let url = baseURL.appendingPathComponent("register")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(user)
            
        } catch {
            print(error)
            completion(error, nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error, nil)
                return
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Token.self, from: data)
                    self.sessionToken = response
                } catch {
                    print(error)
                }
            }
            completion(nil, self.sessionToken)
        }.resume()
        
    }
    
    
    
}
