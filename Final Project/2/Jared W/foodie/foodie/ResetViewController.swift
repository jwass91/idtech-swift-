//
//  ResetViewController.swift
//  foodie
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

 @IBOutlet weak var email: UITextField!
    
    func displayAlert(title: String, message: String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func sendEmail(sender: AnyObject) {
        PFUser.requestPasswordResetForEmailInBackground(email.text)
        
        displayAlert("Email Sent", message: "Check your email to reset your password")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
