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
            self.timeLabel.text = comment.time
            self.commentLabel.text = comment.text
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
