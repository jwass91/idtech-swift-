//
//  EditViewController.swift
//  foodie
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var user = PFUser.currentUser()?.objectId
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func save(sender: AnyObject) {
     saveProfile()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var bio: UITextView!
   
    func displayAlert(title: String, message: String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func addProfileImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Choose your image source", preferredStyle: UIAlertControllerStyle.ActionSheet)
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let imageSize = image.size
        let width = imageSize.width
        let height = imageSize.height
        
        if width != height {
            let newDimensions = min(width, height)
            let widthOffset = (width - newDimensions) / 2
            let heightOffset = (height - newDimensions) / 2
            
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimensions, newDimensions), false, 0.0)
            image.drawAtPoint(CGPointMake(-widthOffset, -heightOffset), blendMode: kCGBlendModeCopy, alpha: 1.0)
            
            image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContext(CGSizeMake(150, 150))
        
        let context = UIGraphicsGetCurrentContext()
        
        image.drawInRect(CGRectMake(0, 0, 150, 150))
        
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        
        profileImageView.image = smallImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name:"person.png", data:imageData)
        
      
//        var userPhoto = PFObject(className:"ProfilePic")
//        userPhoto["profilePic"] = imageFile
//        userPhoto["user"] = user
//        userPhoto.saveInBackground()
//        


        
    }
   
    @IBAction func dismissPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveProfile() {
        var lengthof = bio.text
        var length = count(lengthof)
        
        if length > 150 {
            displayAlert("Cannot Save", message: "Bio must be less then 150 characters. You are \(length-150) characters over.")
        }else{
        
        let profileImageData = UIImageJPEGRepresentation(self.profileImageView.image, 0.6)
        
        let profileImageFile = PFFile(data: profileImageData)
        
        PFUser.currentUser()?["profilePic"] = profileImageFile as PFFile
//        PFUser.currentUser()["profileImage"] = profileImageFile
        
        PFUser.currentUser()?["bio"] = bio.text as String

        
        PFUser.currentUser()?.saveInBackground()
        }
    }
    
//    var user = PFUser.currentUser()
//    var imageToSend = PFObject(className: "User")
//    imageToSend["photo"] = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(image, 0.5))
//    imageToSend.save()
    


    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentbio = PFUser.currentUser()?["bio"] as! String!
        println(currentbio)
        bio.text = currentbio
        
        let profileImageFile = PFUser.currentUser()?["profilePic"] as? PFFile
        profileImageFile!.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if error == nil {
                self.profileImageView.image = UIImage(data:data!)
            }
        })
        // Do any additional setup after loading the view.
        
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
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
