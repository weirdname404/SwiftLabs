//
//  TweetCell.swift
//  SocialApp
//
//  Created by Александр Лебедев on 15/03/2017.
//  Copyright © 2017 Александр Лебедев. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var tweetUserAvatar: UIImageView!
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
