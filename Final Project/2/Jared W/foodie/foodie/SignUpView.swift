//
//  SignUpView.swift
//  foodie
//
//  Created by iD Student on 7/27/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import Parse

class SignUpView: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    func myMethod() {
        var user = PFUser()
        user.username = username.text
        user.password = password.text
        user.email = email.text
        var profileFile = UIImageJPEGRepresentation(profilePicture.image, 0.6)
        var profileData = PFFile(data: profileFile)
        user["profilePic"] = profileData
//        PFUser.currentUser()?.saveInBackground()
    
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as! NSString
                // Show the errorString somewhere and let the user try again.
                self.displayAlert("Sign Up Error", message: "\(errorString)")

            } else {
                
                PFUser.logInWithUsernameInBackground(self.username.text, password: self.password.text, block: {(user, error) -> Void in
                    if error == nil {
                        println("Logged in!")
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        self.performSegueWithIdentifier("login", sender: self)
                        self.displayAlert("User Created", message: "")
                    }else{
                        self.displayAlert("Login Error", message: "Incorrect username or password")
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    }
                })

            }
        }
    }
    func displayAlert(title: String, message: String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
           
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func signUp(sender: AnyObject) {
        if username.text == "" || password.text == "" || email.text == ""{
         displayAlert("Error", message: "Please fill out all fields")
        }else{
            if password.text == confirmpassword.text {
                myMethod()
            }
            else {
                displayAlert("Error", message: "Passwords do not match")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
