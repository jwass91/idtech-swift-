//
//  UserViewController.swift
//  foodie
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import Parse

class UserViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var posts: UILabel!
    
    @IBOutlet weak var followers: UILabel!
    
    @IBOutlet weak var following: UILabel!
    
    @IBOutlet weak var bio: UILabel!
    
    var usernames = [""]
    var userids = [""]
    var isFollowing = ["":false] // dictionary of Booleans
    var refresher: UIRefreshControl!
    
    @IBOutlet weak var username: UILabel!
    var user: PFUser?
    
    required init(coder decoder: NSCoder) {
        user = PFUser.currentUser()
        
        super.init(coder: decoder)
    }
    
    var followersCount = 0
    var followingCount = 0
    
    
//    -------------------------------------------------
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
                            
                            //Parse check who is following who
                            var query = PFQuery(className: "followers")
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                                if let objects = objects { //check if objects exists
                                    if objects.count > 0 { //check if tutors exist
                                        
                                        self.isFollowing[user.objectId!] = true
                                    } else {
                                        self.isFollowing[user.objectId!] = false
                                    }
                                }
                                
                                if self.isFollowing.count == self.usernames.count {
                                    
//                                    self.tableView.reloadData()
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
    
//    -------------------------------------------------
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let profileImageFile = PFUser.currentUser()?["profilePic"] as? PFFile
        profileImageFile!.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if error == nil {
                self.profileImageView.image = UIImage(data:data!)
            }
        })

        
        
        // Do any additional setup after loading the view.
        if let user = self.user {
            username.text = user.username
            bio.text = user["bio"] as! String!
//            
//        bio.layer.borderColor = [[UIColor colorWithRed:202.0/255.0 green:0 blue:11/255.0 alpha:1] CGColor
//        bio.layer.borderWidth = 3.0;
            
            if let name = user["name"] as? String {
                username.text = name
            }
        }
        posts.text = "1"
        followers.text = "1"
        following.text = "1"
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

