//
//  User.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/12/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import Foundation

public class User {
    var username: String
    var password: String
    var email: String
    var defaultLocation: String
    
    init(username: String, password: String, email: String, defaultLocation: String) {
        self.username = username
        self.password = password
        self.email = email
        self.defaultLocation = defaultLocation
    }
}
