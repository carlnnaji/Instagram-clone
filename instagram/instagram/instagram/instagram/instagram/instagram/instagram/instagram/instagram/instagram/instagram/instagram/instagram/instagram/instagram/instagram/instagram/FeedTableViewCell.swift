//
//  FeedTableViewCell.swift
//  instagram
//
//  Created by carlnnaji on 8/16/17.
//  Copyright © 2017 carlnnaji. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var postedImage: UIImageView!
    @IBOutlet var comment: UILabel!
    @IBOutlet var userInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
