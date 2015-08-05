
import UIKit
import Parse
import ParseUI

class HomeTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titles = [String]()
    var usernames = [String]()
    var images = [UIImage]()
    var dates = [NSDate]()
    var profileimages = [UIImage]()
    var imageFiles = [PFFile]()
    var profileFiles = [PFFile]()
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadParseData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
//       self.refresher.startRefreshing()
        
        var getFollowedUsersQuery = PFQuery(className: "followers")
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                
//                println(objects)
                var followedUser = ""
                
                for object: AnyObject in objects! {
                    
                    followedUser = object["following"] as! String
                    
                    
                    var query = PFQuery(className:"Post")
                    query.whereKey("idt", equalTo:followedUser)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]?, error: NSError?) -> Void in
                        if error == nil {
                            // The find succeeded.
                            println("Successfully retrieved \(objects!.count) images.")
                            // Do something with the found objects
                            for object: AnyObject in objects! {
                                
                                self.titles.append(object["title"] as! String)
                                self.usernames.append(object["username"] as! String)
//                                self.dates.append(object["createdAt"] as! NSDate)
                                self.imageFiles.append(object["imageFile"] as! PFFile)
                                
                            
                                println("below is pics")
                                println(self.imageFiles)
                                
                                self.tableView.reloadData()
//                                self.refresher.endRefreshing()
                                
                            }
                            } else {
                            // Log details of the failure
                            println(error)
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
        
    }
    
   var userArray : NSMutableArray = []
    
    func loadParseData() {
        var getFollowedUsersQuery = PFQuery(className: "followers")
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                var followedUser2 = ""
                
                for object: AnyObject in objects! {
                    
                    followedUser2 = object["following"] as! String
                    
                
//                var query = PFQuery(className:"Post")
//                query.whereKey("idt", equalTo: followedUser2)
                
                //println(objects)
                var followedUser = ""
//                
//                for object: AnyObject in objects! {
//                    
//                    followedUser = object["idt"] as! String
                    

        var query : PFQuery = PFUser.query()!
        query.whereKey("objectId", equalTo: followedUser)
        query.findObjectsInBackgroundWithBlock {
       
            (objects, error) -> Void in
            
            if error == nil {
                if let objects = objects {
                    println("\(objects.count) profiles are listed")
                    for object in objects {
                        self.profileFiles.append(object["profilePic"] as! PFFile)
                    }
                    self.tableView.reloadData()
                }
            } else {
                println("There is an error")
            }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println(titles.count)
        return titles.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var myCell:HomeTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! HomeTableViewCell
        
        myCell.description2.text = titles[indexPath.row]
        myCell.username.text = usernames[indexPath.row]
        
        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
//        myCell.date.text = dateFormatter.stringFromDate(dates[indexPath.row])
        
            imageFiles[indexPath.row].getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData!)
                
                myCell.picture.image = image
                
            }
        }
//        profileFiles[indexPath.row].getDataInBackgroundWithBlock{
//                    (imageData: NSData?, error: NSError?) -> Void in
//                    
//                    if error == nil {
//                        
//                        let image = UIImage(data: imageData!)
//                        
//                        myCell.profilepic.image = image
//                        
//            }

            
            
            
    
        
        return myCell
//        profileFiles[indexPath.row].getDataInBackgroundWithBlock{
//            (imageData2: NSData?, error: NSError?) -> Void in
//            
//            if error == nil {
//                
//                let image2 = UIImage(data: imageData2!)
//                
//                myCell.profilepic.image = image2
//            }
//            
//            
//        }
//        return myCell
        
    }
}

////
////  HomeTableViewController.swift
////  foodie
////
////  Created by iD Student on 7/29/15.
////  Copyright (c) 2015 Jared Wasserman. All rights reserved.
////
//
//import UIKit
//import Parse
//import ParseUI
//
//class HomeTableViewController: UIViewController {
//    
//    
//
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var profilePic: UIImageView!
//    @IBOutlet weak var userName: UILabel!
//    @IBOutlet weak var image: UIImageView!
//    
////    @IBOutlet weak var profilePic: UIImageView!
////    
////    @IBOutlet weak var username: UILabel!
////    
////    @IBOutlet weak var image: UIImageView!
////    
////    @IBOutlet weak var likes: UILabel!
//    
////    @IBOutlet weak var unlike: UIButton!
////    @IBOutlet weak var like: UIButton!
////    
////    @IBAction func unlike(sender: AnyObject) {
////        
////        unlike.hidden = true
////        like.hidden = false
////    }
////    
////    @IBAction func like(sender: AnyObject) {
////        like.hidden = true
////        unlike.hidden = false
////    }
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
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }
//
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("posts", forIndexPath: indexPath) as! HomeTableViewCell
//
//
//    
//
//        return cell
//    }
//
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
