//
//  HomeTableViewCell.swift
//  foodie
//
//  Created by iD Student on 7/29/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import Parse

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var picture: UIImageView!
//    @IBOutlet weak var description: UILabel!
    @IBOutlet weak var description2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
