//
//  Mentors.swift
//  Mentors International
//
//  Created by Jaspal on 2/7/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import Foundation

struct Token: Codable {
    var user: User
    var token: String
}

struct User: Codable {
    // returned by the server
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var country: String
    // check with Dan
    var type: String
    var region: Int
    
    init(email: String, firstName: String, lastName: String, country: String, type: String, region: Int) {
        self.id = Int()
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.country = country
        self.type = type
        self.region = region
        
    }
}
