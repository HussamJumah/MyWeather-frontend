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
    var id: String
    var username: String
    var password: String
    var email: String
    var defaultZipcode: String
    
    init(id: String, username: String, password: String, email: String, defaultZipcode: String) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.defaultZipcode = defaultZipcode
    }
    
    static func FromJSON(_ json: JSON) -> User {
        let id = json["_id"].stringValue
        let username = json["username"].stringValue
        let password = json["password"].stringValue
        let email = json["email"].stringValue
        let defaultZipCode = json["defaultZipcode"].stringValue
        
        
        return User(id: id,username: username, password: password, email: email, defaultZipcode: defaultZipCode)
    }
}
