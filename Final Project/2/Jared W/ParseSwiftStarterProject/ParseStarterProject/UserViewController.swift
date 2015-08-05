//
//  UserViewController.swift
//  ParseStarterProject
//
//  Created by iD Student on 7/23/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UserViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var userArray: [String] = []
    var activeRecipient = 0
    var timer = NSTimer()
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        var imageToSend = PFObject(className: "image")
        imageToSend["photo"] = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(image, 0.5))
        imageToSend["senderUsername"] = PFUser.currentUser()!.username
        imageToSend["recipientUsername"] = userArray[activeRecipient]
        imageToSend.save()
        
    }
    
    var user: PFUser?
    var refresher: UIRefreshControl!
    required init(coder decoder: NSCoder){
        user = PFUser.currentUser()
        super.init(coder: decoder)
    }
    
    func checkMessageForUser(user: PFUser){
        refresh()
    }
    func refresh(){
     checkForMessage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var query = PFUser.query()
        query!.whereKey("username", notEqualTo: PFUser.currentUser()!.username!)
        var users = query?.findObjects()
        
        for user in users! {
            userArray.append(user.username as String!)
            tableView.reloadData()
        }
        
        
        if let user = self.user {
            checkMessageForUser(user)
//            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("checkForMessage"), userInfo: nil, repeats: true)
        }
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
//        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("checkForMessage"), userInfo: nil, repeats: true)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func checkForMessage(){
        println("checking for message")
        var query = PFQuery(className: "image")
        query.whereKey("recipientUsername", equalTo: (PFUser.currentUser())!.username!)
        
        var images = query.findObjects()
        var done = false
     
       
        
        for image in images! {
            if done == false {
                var imageView:PFImageView? = PFImageView()
                imageView?.file = (image["photo"] as! PFFile)
                
                imageView!.loadInBackground({(photo, error) -> Void in
                
                    if error == nil {
                    var senderUsername = ""
                        
                        if image["senderUsername"] != nil{
                            senderUsername = image["senderUsername"] as! String
                        }else{
                            senderUsername = "Unknown User"
                        }
                        
                        var alert = UIAlertController(title: "You've got a message!", message: "From \(senderUsername)", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                            
                            var backgroundView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
                            backgroundView.backgroundColor = UIColor.blackColor()
                            backgroundView.alpha = 0.9
                            backgroundView.tag = 3
                            self.view.addSubview(backgroundView)
                            
                            var displayedImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
                            displayedImage.image = photo
                            displayedImage.tag = 3
                            displayedImage.contentMode = UIViewContentMode.ScaleAspectFit
                            self.view.addSubview(displayedImage)
                            
                            image.deleteInBackground()
                            self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("hideMessage"), userInfo: nil, repeats: true)
                            
                            
                        }))
//                        self.refresher.endRefreshing()
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                })
                done = true
                
               
            
            }
        }
        
    }
    
    func hideMessage(){
        for subview in self.view.subviews{
            if subview.tag == 3{
            subview.removeFromSuperview()
            self.refresher.endRefreshing()
            
            }
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return userArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel!.text = userArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activeRecipient = indexPath.row
        pickImage(self)
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
    }
   

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

}
