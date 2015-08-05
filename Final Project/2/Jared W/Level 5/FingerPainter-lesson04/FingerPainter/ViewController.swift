/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class ViewController:UIViewController,UIPickerViewDataSource,UIPickerViewDelegate  {

    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    var start: CGPoint?
    let pickerData = [
        ["magenta","green","blue","red","yellow"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        start = touch.locationInView(view)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let end = touch.locationInView(view)
        if let start = self.start {
            drawFromPoint(start, toPoint: end)
        }
        self.start = end
    }
    
   
    
    func drawFromPoint(start: CGPoint, toPoint end: CGPoint) {
        // print coordinate with breakpoint here
        UIGraphicsBeginImageContext(canvas.frame.size)
        let context = UIGraphicsGetCurrentContext()
        canvas.image?.drawInRect(CGRect(x: 0, y: 0, width: canvas.frame.size.width, height: canvas.frame.size.height))
        CGContextSetLineWidth(context, 5)
        CGContextSetStrokeColorWithColor(context, UIColor.magentaColor().CGColor)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, start.x, start.y)
        CGContextAddLineToPoint(context, end.x, end.y)
        CGContextStrokePath(context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        canvas.image = newImage
    }
    @IBAction func clear(sender: AnyObject) {
        canvas.image = nil
    }
    @IBAction func popColor(sender: AnyObject) {
    }

}

