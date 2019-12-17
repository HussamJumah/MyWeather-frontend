//
//  CommentTableViewCell.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/12/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // Variables
    var comment: Comment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateView() {
        if let comment = comment {
            self.usernameLabel.text = comment.commenter.username
            let time = FormatDateToUTC(from: comment.time, format: "h:mm a")
            self.timeLabel.text = time
            self.commentLabel.text = comment.text
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func FormatDateToUTC(from: String, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = NSTimeZone(name: "UTC") as! TimeZone
        let UTCDate = formatter.date(from: from)
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        let UTCToCurrentFormat = formatter.string(from: UTCDate!)
        return UTCToCurrentFormat
    }
    
}
