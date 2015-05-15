//
//  ViewController.swift
//  Thing3
//
//  Created by Ostap Horbach on 5/15/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicatorLeft: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorRight: UIActivityIndicatorView!
    @IBOutlet weak var deltaLabel: UILabel!
    
    var delta: Double = 0.95;
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        activityIndicatorLeft.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), CGFloat(0.0), CGFloat(1.0), CGFloat(0.0));
        
        toggleCycle();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showLeftActivityIndicator() {
        activityIndicatorLeft.alpha = 1.0;
    }
    
    func showRightActivityIndicator() {
        activityIndicatorRight.alpha = 1.0;
    }
    
    func hideLeftActivityIndicator() {
        activityIndicatorLeft.alpha = 0.0;
    }
    
    func hideRightActivityIndicator() {
        activityIndicatorRight.alpha = 0.0;
    }
    
    func sutupActivityIndicators() {
        showLeftActivityIndicator();
        hideRightActivityIndicator();
    }
    
    func isShowingLeftActivityIndicator()-> Bool
    {
        return activityIndicatorLeft.alpha == 1.0 && activityIndicatorRight.alpha == 0.0
    }
    
    func toggleActivityIndicators() {
        if isShowingLeftActivityIndicator() {
            showRightActivityIndicator();
            hideLeftActivityIndicator();
        } else {
            showLeftActivityIndicator();
            hideRightActivityIndicator();
        }
    }
    
    func a() {
        activityIndicatorRight.startAnimating();
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(delta * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.activityIndicatorRight.stopAnimating();
            
            self.activityIndicatorLeft.startAnimating();
            let delayTime2 = dispatch_time(DISPATCH_TIME_NOW,
                Int64(self.delta * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime2, dispatch_get_main_queue()) {
                self.activityIndicatorLeft.stopAnimating();
            }
        }
    }
    
    func toggleCycle() {
        timer?.invalidate();
        timer = NSTimer.scheduledTimerWithTimeInterval(delta * 2, target: self, selector: Selector("a"), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func deltaChanged(sender: AnyObject) {
        delta = sender.value;
        deltaLabel.text = "\(delta)"
        toggleCycle()
    }

}

