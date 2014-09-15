//
//  MovieCell.swift
//  tomatoes
//
//  Created by Sid Reddy on 9/13/14.
//  Copyright (c) 2014 Sid Reddy. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    var movie: NSDictionary! = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
