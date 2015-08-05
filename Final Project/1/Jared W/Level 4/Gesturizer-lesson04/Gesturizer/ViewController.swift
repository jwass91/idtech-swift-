/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gestureName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func singleTap(sender: UITapGestureRecognizer) {
        gestureName.text = "Tap"
        gestureName.hidden = false
    }
    
    @IBAction func doubleTap(sender: UITapGestureRecognizer) {
        gestureName.text = "Double Tap"
        gestureName.hidden = false
    }
    @IBAction func longPress(sender: AnyObject) {
        gestureName.text = "Long Press"
        gestureName.hidden = false
    }
    
    @IBAction func pinch(sender: AnyObject) {
        gestureName.text = "Pinch"
        gestureName.hidden = false
    }
    @IBAction func rotate(sender: AnyObject) {
        gestureName.text = "Rotate"
        gestureName.hidden = false
    }
    @IBAction func swipeup(sender: AnyObject) {
        gestureName.text = "swipe up"
        gestureName.hidden = false
    }
    @IBAction func swipedown(sender: AnyObject) {
        gestureName.text = "swipe down"
        gestureName.hidden = false
    }
}

