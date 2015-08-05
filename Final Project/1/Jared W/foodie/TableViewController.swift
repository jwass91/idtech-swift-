import UIKit
import Parse
import ParseUI

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var usernames = [""]
    var userids = [""]
    var isFollowing = ["":false] // dictionary of Booleans
    var refresher: UIRefreshControl!
    var image = [PFFile]()
    
    func refresh() {
        var query = PFUser.query()
        query!.findObjectsInBackgroundWithBlock( { (objects, error) -> Void in
            if let users = objects {
                
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                
                self.isFollowing.removeAll(keepCapacity: true)
                
                for object in users {
                    if let user = object as? PFUser {
                        
                        if user.objectId != PFUser.currentUser()!.objectId {
                            
                            self.usernames.append(user.username!)
                            self.userids.append(user.objectId!)
                            self.image.append(object["profilePic"] as! PFFile)
//                            println(image)
                            
                            //Parse check who is following who
                            var query = PFQuery(className: "followers")
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                if let objects = objects {
                                    if objects.count > 0 {
                                        
                                        self.isFollowing[user.objectId!] = true
                                    } else {
                                        self.isFollowing[user.objectId!] = false
                                    }
                                }
                                
                                if self.isFollowing.count == self.usernames.count {
                                    
                                    self.tableView.reloadData()
                                    self.refresher.endRefreshing()
                                }
                            })
                            
                        }
                    }
                }
            }
            println(self.usernames)
            println(self.userids)
            
            
        })
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! usertableviewcell
//        var object = PFObject()
        cell.textLabel?.text = usernames[indexPath.row]
//
//        image[indexPath.row].getDataInBackgroundWithBlock{
//            (imageData: NSData?, error: NSError?) -> Void in
//            
//            if error == nil {
////                
//                let images = UIImage(data: imageData!)
//                
//                cell.customFlag.image = images
//             //            } else {
//                print(error?.localizedDescription)
//            }
//
        
        
//        println(userids[indexPath.row])
//        var initialThumbnail = UIImage(named: "person.png")
//        cell.customFlag.image = initialThumbnail
//        if let thumbnail = object["flag"] as? PFFile {
//            cell.customFlag.file = thumbnail
//            cell.customFlag.loadInBackground()
//        }

        
//        cell.imageView.image = []
        
        let followObjectId = userids[indexPath.row]
        
        if isFollowing[followObjectId] == true { // If following add checkmarks
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        let followObjectId = userids[indexPath.row]
        
        if isFollowing[followObjectId] == false {
            
            isFollowing[followObjectId] = true
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            var following = PFObject(className: "followers")
            
            following["following"] = userids[indexPath.row]
            following["follower"] = PFUser.currentUser()!.objectId
            
            following.saveInBackground()
            
        } else {
            isFollowing[followObjectId] = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            //Parse check who is following who
            var query = PFQuery(className: "followers")
            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("following", equalTo: userids[indexPath.row])
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects { //check if tutors exists
                    for object in objects {
                        object.deleteInBackground()
                    }
                }
                
                if self.isFollowing.count == self.usernames.count {
                    self.tableView.reloadData()
                }
            })
            
            
        }
    }
    func logout() {
        PFUser.logOut()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}





////
////  TableViewController.swift
////  foodie
////
////  Created by iD Student on 7/27/15.
////  Copyright (c) 2015 Jared Wasserman. All rights reserved.
////
//
//import UIKit
//
//class TableViewController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
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
//
//    /*
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
