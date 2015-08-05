//
//  Destination.swift
//  
//
//  Created by iD Student on 7/21/15.
//
//

import Foundation
import CoreData

class Destination: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var name: String
    @NSManaged var lat: NSNumber
    @NSManaged var lon: NSNumber
    @NSManaged var latDelta: NSNumber
    @NSManaged var lonDelta: NSNumber

}
