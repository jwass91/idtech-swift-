//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func signUp(sender: AnyObject) {
        
    }
    @IBAction func login(sender: AnyObject) {
        loginUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: nil)
        }
    }
    func displayAlert(title: String, message: String){
    var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginUser(){
        if username.text == "" || password.text == "" {
            displayAlert("Error in form!", message: "Please enter username and password")
        }else{
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            PFUser.logInWithUsernameInBackground(username.text, password: password.text, block: {(user, error) -> Void in
                if error == nil {
                    println("Logged in!")
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    self.performSegueWithIdentifier("login", sender: self)
                }else{
                    self.displayAlert("Login Error", message: "Please try agian")
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                }
            })
        }
    }
}
