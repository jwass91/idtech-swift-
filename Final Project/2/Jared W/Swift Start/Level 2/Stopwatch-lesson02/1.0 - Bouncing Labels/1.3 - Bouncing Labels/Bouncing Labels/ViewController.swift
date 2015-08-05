//
//  ViewController.swift
//  Bouncing Labels
//
//  Created by Paul Solt on 10/6/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 1. Declare ivars
    var myFirstLabel: UILabel!
    var iPhoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 2. Create the labels
        myFirstLabel = UILabel()
        myFirstLabel.text = "My first"
        myFirstLabel.font = UIFont.systemFontOfSize(36)
        myFirstLabel.sizeToFit()
        myFirstLabel.center = CGPoint(x: 100, y: 40)
        view.addSubview(myFirstLabel)
        
        iPhoneLabel = UILabel()
        iPhoneLabel.text = "iPhone app"
        iPhoneLabel.font = UIFont.boldSystemFontOfSize(48)
        iPhoneLabel.sizeToFit()
        iPhoneLabel.center = CGPoint(x: 200, y: 90)
        view.addSubview(iPhoneLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

