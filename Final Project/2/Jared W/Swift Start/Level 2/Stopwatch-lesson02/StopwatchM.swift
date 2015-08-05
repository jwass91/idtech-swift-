//
//  StopwatchM.swift
//  Stopwatch
//
//  Created by iD Student on 7/7/15.
//  Copyright (c) 2015 Your School. All rights reserved.
//

import Foundation

class Stopwatch {

    private var startTime: NSDate?
    
    var timer: NSTimer!
    
    var elapsedTime: NSTimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }
}