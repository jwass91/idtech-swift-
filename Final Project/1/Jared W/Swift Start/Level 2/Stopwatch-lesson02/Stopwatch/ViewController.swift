/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class ViewController: UIViewController {
    
    var passingtime: NSTimeInterval!
    
    let stopwatch = Stopwatch()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updatedate:", userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBAction func startPress(sender: UIButton) {
        println("Started")
        stopwatch.start()
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTime:", userInfo: nil, repeats: true)
    }
    @IBAction func Pause(sender: AnyObject) {
         if(stopwatch.isRunning){
        println("Paused")
        passingtime = passingtime + stopwatch.elapsedTime
        stopwatch.stop()
         } else {
            stopwatch.stop()
        }
    }
    
    @IBAction func Reset(sender: AnyObject) {
        println("Reset")
        stopwatch.stop()
        timerLabel.text = "00:00.0"
        timerLabel.textColor = UIColor.blackColor()
        passingtime = 0
    }
    
    
    func updateTime(timer:NSTimer){
        if(passingtime == nil){
            passingtime = 0
        }
        
        if stopwatch.isRunning{
            let minutes = Int((stopwatch.elapsedTime+passingtime!)/60)
            let seconds = Int((stopwatch.elapsedTime+passingtime!)%60)
            let tenths = Int((stopwatch.elapsedTime+passingtime!)*10%10)
            timerLabel.text = String(format:"%02d:%02d.%d",minutes,seconds,tenths)
            timerLabel.textColor = UIColor.blueColor()
        }
            else{
                timer.invalidate()
            }
        }
    
    func updatedate(timer:NSTimer){
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("hh:mm:ss")
        time.text = formatter.stringFromDate(date)
        
        
    }
    
    }
    
    var dropd: UILabel!
    





