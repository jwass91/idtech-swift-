//
//  Pin.swift
//  Maps
//
//  Created by iD Student on 7/21/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class Pin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D){
    self.coordinate = coordinate
    }
}
