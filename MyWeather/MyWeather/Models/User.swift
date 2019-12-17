//
//  User.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/12/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import Foundation
import SwiftyJSON

public class User {
    var username: String
    var password: String
    var email: String
    var defaultZipcode: String
    
    init(username: String, password: String, email: String, defaultZipcode: String) {
        self.username = username
        self.password = password
        self.email = email
        self.defaultZipcode = defaultZipcode
    }
    
    static func FromJSON(_ json: JSON) -> User {
        let username = json["username"].stringValue
        let password = json["password"].stringValue
        let email = json["email"].stringValue
        let defaultZipCode = json["defaultZipcode"].stringValue
        
        
        return User(username: username, password: password, email: email, defaultZipcode: defaultZipCode)
    }
}
