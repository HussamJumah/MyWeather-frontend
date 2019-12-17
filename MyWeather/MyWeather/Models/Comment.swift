//
//  Comment.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/12/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import Foundation
import SwiftyJSON

class Comment {
    var commenter: User
    var time: String
    var text: String
    
    init(commenter: User, time: String, text: String) {
        self.commenter = commenter
        self.time = time
        self.text = text
    }
    
    static func FromJSON(_ json: JSON) -> Comment {
        let comment = json["comment"].stringValue
        let commenter = User.FromJSON(json["commenter"])
        let commentedAt = json["commentedAt"].stringValue
        
        return Comment(commenter: commenter, time: commentedAt, text: comment)
      }
}
