/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class ViewController: UIViewController {
	
    var mylabel:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mylabel = UILabel()
        mylabel.text = "this is my label"
        mylabel.font = UIFont.systemFontOfSize(24)
        mylabel.center = CGPoint(x: 120, y: 320)
        mylabel.sizeToFit()
        view.addSubview(mylabel)
        UIView.animateWithDuration(5.5, delay: 1.0, usingSpringWithDamping: 100.9, initialSpringVelocity: 1.0, options: nil, animations: { () -> Void in
            self.mylabel.center = CGPoint(x: 200, y: 100)
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeBackgroundColor(sender: UIButton) {
        view.backgroundColor = UIColor(
            red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
            green:CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
            blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
            alpha: CGFloat(1)
        )
    }
    @IBAction func buttonpressed(sender: AnyObject) {
         view.backgroundColor = UIColor.whiteColor()
    }

} 

