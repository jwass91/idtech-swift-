//////
//////  PostViewController.swift
//////  foodie
//////
//////  Created by iD Student on 7/28/15.
//////  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//////
////

import UIKit
import Parse
import ParseUI

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var done = false
    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction (UIAlertAction(title: "OK", style: .Default, handler: {
            (action) -> Void in
            if self.done == true {
            self.navigationController?.popViewControllerAnimated(true)
                self.done = false
            }
      
            
           
        }))
            self.presentViewController(alert, animated: true, completion: nil)
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var imageview: UIImageView!
    var photoSelected:Bool = false
    
    @IBOutlet weak var shareText: UITextView!
//    @IBOutlet var shareText: UITextField!
    @IBAction func chooseImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true // for now
        photoSelected = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
        
    }
    @IBAction func logoutPressed(sender: AnyObject) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier("logoutPressed", sender: self)
        
    }
    
    @IBAction func postImage(sender: AnyObject) {
        var error = ""
        var lengthof = shareText.text
        var length = count(lengthof)
        println(length)
        if (photoSelected == false) {
            error = "Please select an image"
            displayAlert("Cannot post", error: error)
           
        } else if (shareText.text == ""){
            error = "Please enter a description"
            displayAlert("Cannot post", error: error)
            
        } else if length > 215 {
        error = "Description must be less then 215 characters. You are \(length-215) characters over."
        displayAlert("Cannot post", error: error)
        }
    
    
        if (error != "") {
            
            if error == "Please select an image" {
            }
            else if error == "Please enter a description" {
            
            }
            else if error == "Description must be less then 215 characters. You are \(length-215) characters over." {
                
            }
            else{
            var activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            displayAlert("Cannot post", error: error)
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            }
        
        }else {
            var post = PFObject(className: "Post")
            post["title"] = shareText.text
            post["username"] = PFUser.currentUser()!.username
            post["idt"] = PFUser.currentUser()!.objectId
            
            
            post.saveInBackgroundWithBlock{ (success, error) -> Void in
                if success == false {
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayAlert("Could not post recipe", error: "Please try again later")
                } else {
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    
                    post["imageFile"] = imageFile
                    
                    post.saveInBackgroundWithBlock{ (success, error) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if success == false {
                            self.displayAlert("Could not post image", error: "Please try again later")
                        } else {
                            self.done = true
                            self.displayAlert("Recipe Posted!", error: "Recipe was posted successfully!")
                            
                            //self.photoSelected = 0
                            self.imageToPost.image = UIImage(named: "donut")
                            
                            self.shareText.text = ""
                            
                            println("posted successfully")
                            
                        }
                    }
                }
            }
        }
    }
    
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!,editingInfo: [NSObject : AnyObject]!) {
        println("Image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        photoSelected = true
        imageToPost.image = image
    }
    
    
    @IBOutlet var imageToPost: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //photoSelected = 0
//        imageToPost.image = UIImage(named: "donut")
        
        shareText.text = ""
        
    }
    
        @IBAction func addProfileImage(sender: AnyObject) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
    
            let actionSheet = UIAlertController(title: "Picture of your food", message: "Choose your image source", preferredStyle: UIAlertControllerStyle.ActionSheet)
            actionSheet.addAction(UIAlertAction(title: "Camera Roll", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
    
            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }))
    
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
    
            self.presentViewController(actionSheet, animated: true, completion: nil)
        }
    
        func displayAlert(title: String, message: String){
            var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
            }))
            
            func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
                var imageToPost = info[UIImagePickerControllerOriginalImage] as! UIImage
                photoSelected = true
                //        let imageSize = image.size
                //        let width = imageSize.width
                //        let height = imageSize.height
                //
                //        if width != height {
                //            let newDimensions = min(width, height)
                //            let widthOffset = (width - newDimensions) / 2
                //            let heightOffset = (height - newDimensions) / 2
                //
                //            UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimensions, newDimensions), false, 0.0)
                //            image.drawAtPoint(CGPointMake(-widthOffset, -heightOffset), blendMode: kCGBlendModeCopy, alpha: 1.0)
                //            
                //            image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
                //            UIGraphicsEndImageContext()
            }
            
            
    }
    
    
    
    
    func textFieldShouldReturn(shareText: UITextField!) -> Bool {
        
        shareText.resignFirstResponder()
        return true
    }
//    override func touchesBegan(touches: (NSSet!), withEvent event: (UIEvent!)) {
//        self.view.endEditing(true)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}













//import UIKit
//import Parse
//import ParseUI
//
//class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
//
//    @IBAction func chooseImage(sender: AnyObject) {
//        
//    }
//    override func viewDidLoad() {
//                super.viewDidLoad()
//                //photoSelected = 0
//                imageToPost.image = UIImage(named: "donut")
//        
//                shareText.text = ""
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    var photoSelected:Bool = false
//    
//    @IBOutlet weak var shareText: UITextView!
//    @IBAction func chooseImage(sender: AnyObject) {
//        var image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        image.allowsEditing = true // for now
//        
//        self.presentViewController(image, animated: true, completion: nil)
//        
//        
//    }
//    
//    
//    @IBOutlet weak var imageView: UIImageView!
//    @IBAction func postImage(sender: AnyObject) {
//        var error = ""
//        
//        if (photoSelected == false) {
//            error = "Please select an image"
//        } else if (shareText.text == ""){
//            error = "Please enter a recipe!"
//        }
//        if (error != "") {
//            
//            var activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
//            activityIndicator.center = self.view.center
//            activityIndicator.hidesWhenStopped = true
//            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//            view.addSubview(activityIndicator)
//            activityIndicator.startAnimating()
//            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
//            
//            displayAlert("Cannot post", error: error)
//            
//            self.activityIndicator.stopAnimating()
//            UIApplication.sharedApplication().endIgnoringInteractionEvents()
//            
//            
//        } else {
//            var post = PFObject(className: "Post")
//            post["title"] = shareText.text
//            post["username"] = PFUser.currentUser().username
//            
//            
//            post.saveInBackgroundWithBlock{ (success: Bool!, error: NSError!) -> Void in
//                if success == false {
//                    self.activityIndicator.stopAnimating()
//                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
//                    
//                    self.displayAlert("Could not post recipe", error: "Please try again later")
//                } else {
//                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
//                    
//                    let imageFile = PFFile(name: "image.png", data: imageData)
//                    
//                    post["imageFile"] = imageFile
//                    
//                    post.saveInBackgroundWithBlock{ (success: Bool!, error: NSError!) -> Void in
//                        
//                        self.activityIndicator.stopAnimating()
//                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
//                        
//                        if success == false {
//                            self.displayAlert("Could not post image", error: "Please try again later")
//                        } else {
//                            
//                            self.displayAlert("Recipe Posted!", error: "Recipe was posted successfully!")
//                            
//                            //self.photoSelected = 0
//                            self.imageToPost.image = UIImage(named: "donut")
//                            
//                            self.shareText.text = ""
//                            
//                            println("posted successfully")
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!,editingInfo: [NSObject : AnyObject]!) {
//        println("Image selected")
//        self.dismissViewControllerAnimated(true, completion: nil)
//        
//        photoSelected = true
//        imageToPost.image = image
//    }
//    
//    @IBOutlet var imageToPost: UIImageView!
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        //photoSelected = 0
////        imageToPost.image = UIImage(named: "donut")
////        
////        shareText.text = ""
////        
////    }
//    func textFieldShouldReturn(shareText: UITextField!) -> Bool {
//        
//        shareText.resignFirstResponder()
//        return true
//    }
//    override func touchesBegan(touches: (NSSet!), withEvent event: (UIEvent!)) {
//        self.view.endEditing(true)
//    }
//    
//   
//    
//}
//    
////    
////    
////    
////    
////    
////    @IBAction func addProfileImage(sender: AnyObject) {
////        let imagePicker = UIImagePickerController()
////        imagePicker.delegate = self
////        
////        let actionSheet = UIAlertController(title: "Profile Picture", message: "Choose your image source", preferredStyle: UIAlertControllerStyle.ActionSheet)
////        actionSheet.addAction(UIAlertAction(title: "Camera Roll", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
////            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
////            self.presentViewController(imagePicker, animated: true, completion: nil)
////        }))
////        
////        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
////            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
////            self.presentViewController(imagePicker, animated: true, completion: nil)
////        }))
////        
////        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
////        
////        self.presentViewController(actionSheet, animated: true, completion: nil)
////    }
////    
////    func displayAlert(title: String, message: String){
////        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
////        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
////            
////        }))
////        self.presentViewController(alert, animated: true, completion: nil)
////    }
////    
////    @IBAction func addRecipe(sender: AnyObject) {
////        if decription.text == "" || decription.text == "Describe your food here"{
////             displayAlert("Error", message: "You must add a description")
////        } else if imageView.image = nil {
////            displayAlert("Error", message: "You must select an image")
////        } else {
////            
////        self.performSegueWithIdentifier("addrecipe", sender: self)
////        }
////    }
////    
////    @IBAction func postWithOutRecipe(sender: AnyObject) {
////        if decription.text == "" || decription.text == "Describe your food here"{
////            displayAlert("Error", message: "You must add a description")
////        } else if imageView.image = nil {
////            displayAlert("Error", message: "You must select an image")
////        } else {
////            
////            self.performSegueWithIdentifier("addrecipe", sender: self)
////        }
////    }
////    
////
////    /*
////    // MARK: - Navigation
////
////    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////        // Get the new view controller using segue.destinationViewController.
////        // Pass the selected object to the new view controller.
////    }
////    */
////
////}
////
////
////
///////////////////////////////////
////
////import UIKit
////import Parse
////import ParseUI
////
////class postViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
////    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
////    
////    func displayAlert(title:String, error:String) {
////        
////        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
////        alert.addAction (UIAlertAction(title: "OK", style: .Default, handler: {
////            action in self.dismissViewControllerAnimated(true, completion: nil)
////        }))
////        self.presentViewController(alert, animated: true, completion: nil)
////        
////    }
////    
////    var photoSelected:Bool = false
////    
////    @IBOutlet var shareText: UITextField!
////    @IBAction func chooseImage(sender: AnyObject) {
////        var image = UIImagePickerController()
////        image.delegate = self
////        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
////        image.allowsEditing = true // for now
////        
////        self.presentViewController(image, animated: true, completion: nil)
////        
////        
////    }
////    @IBAction func logoutPressed(sender: AnyObject) {
////        
////        PFUser.logOut()
////        self.performSegueWithIdentifier("logoutPressed", sender: self)
////        
////    }
////    
////    
////    @IBAction func postImage(sender: AnyObject) {
////        var error = ""
////        
////        if (photoSelected == false) {
////            error = "Please select an image"
////        } else if (shareText.text == ""){
////            error = "Please enter a recipe!"
////        }
////        if (error != "") {
////            
////            var activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
////            activityIndicator.center = self.view.center
////            activityIndicator.hidesWhenStopped = true
////            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
////            view.addSubview(activityIndicator)
////            activityIndicator.startAnimating()
////            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
////            
////            displayAlert("Cannot post", error: error)
////            
////            self.activityIndicator.stopAnimating()
////            UIApplication.sharedApplication().endIgnoringInteractionEvents()
////            
////            
////        } else {
////            var post = PFObject(className: "Post")
////            post["title"] = shareText.text
////            post["username"] = PFUser.currentUser().username
////            
////            
////            post.saveInBackgroundWithBlock{ (success: Bool!, error: NSError!) -> Void in
////                if success == false {
////                    self.activityIndicator.stopAnimating()
////                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
////                    
////                    self.displayAlert("Could not post recipe", error: "Please try again later")
////                } else {
////                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
////                    
////                    let imageFile = PFFile(name: "image.png", data: imageData)
////                    
////                    post["imageFile"] = imageFile
////                    
////                    post.saveInBackgroundWithBlock{ (success: Bool!, error: NSError!) -> Void in
////                        
////                        self.activityIndicator.stopAnimating()
////                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
////                        
////                        if success == false {
////                            self.displayAlert("Could not post image", error: "Please try again later")
////                        } else {
////                            
////                            self.displayAlert("Recipe Posted!", error: "Recipe was posted successfully!")
////                            
////                            //self.photoSelected = 0
////                            self.imageToPost.image = UIImage(named: "donut")
////                            
////                            self.shareText.text = ""
////                            
////                            println("posted successfully")
////                        }
////                    }
////                }
////            }
////        }
////    }
////    
////    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!,editingInfo: [NSObject : AnyObject]!) {
////        println("Image selected")
////        self.dismissViewControllerAnimated(true, completion: nil)
////        
////        photoSelected = true
////        imageToPost.image = image
////    }
////    
////    @IBOutlet var imageToPost: UIImageView!
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        //photoSelected = 0
////        imageToPost.image = UIImage(named: "donut")
////        
////        shareText.text = ""
////        
////    }
////    func textFieldShouldReturn(shareText: UITextField!) -> Bool {
////        
////        shareText.resignFirstResponder()
////        return true
////    }
////    override func touchesBegan(touches: (NSSet!), withEvent event: (UIEvent!)) {
////        self.view.endEditing(true)
////    }
////    
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
////    
////}
