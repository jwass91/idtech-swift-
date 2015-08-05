//
//  temperatureRange.swift
//  UnitConverter
//
//  Created by iD Student on 7/22/15.
//  Copyright (c) 2015 Your School. All rights reserved.
//

import UIKit

class TemperatureRange: NSObject, UIPickerViewDataSource {
    
   let values = (-100...212).map{$0}
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
}
