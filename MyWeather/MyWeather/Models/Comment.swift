//
//  Comment.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/12/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import Foundation

class Comment {
    var commenter: User
    var time: String
    var text: String
    
    init(commenter: User, time: String, text: String) {
        self.commenter = commenter
        self.time = time
        self.text = text
    }
}
