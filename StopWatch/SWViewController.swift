//
//  SWViewController.swift
//  StopWatch
//
//  Created by Eric on 14-7-27.
//  Copyright (c) 2014年 ThePlant-Eric. All rights reserved.
//

import UIKit

class SWViewController: UIViewController {
    @IBOutlet var displayTimeLabel: UILabel!
    @IBOutlet var exceedMsgLabel: UILabel!
    @IBOutlet var msgImage: UIImage!

    var timer = NSTimer()
    var startTime = NSTimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = UIImage(named: "background.png")
        self.view.backgroundColor = UIColor(patternImage: background)

        // Do any additional setup after loading the view.
    }

    
    @IBAction func start(sender: AnyObject) {
        if !timer.valid {
            let actionSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector:actionSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        timer == nil
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        // Find the difference between current time and strart time
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        // calculate the minutes in elapsed time
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        // calculate the seconds in elapsed time
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        // find out the fraction of millisends to be displayed
        let fraction = UInt8(elapsedTime * 100)
        
        if seconds > 20 {
            exceedMsgLabel.text = "超过20秒了"
        }
        
        // add the leading zero for minutes, seconds and millseconds and store them as string constants
        let startMinutes  = minutes > 9 ? String(minutes):"0" + String(minutes)
        let startSeconds  = seconds > 9 ? String(seconds):"0" + String(seconds)
        let startFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        displayTimeLabel.text = "\(startMinutes):\(startSeconds):\(startFraction)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
