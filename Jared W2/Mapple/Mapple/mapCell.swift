//
//  mapCell.swift
//  Mapple
//
//  Created by iD Student on 7/21/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import MapKit

class mapCell: UITableViewCell {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
