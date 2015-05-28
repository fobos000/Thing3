//
//  InfinityView.swift
//  Thing3
//
//  Created by Ostap Horbach on 5/27/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

import UIKit

class InfinityView: UIView {

    @IBOutlet weak private var contentView:UIView!
    @IBOutlet weak var leftActivity: UIActivityIndicatorView!
    @IBOutlet weak var rightActivity: UIActivityIndicatorView!
    
    var lastAnimationChangeTimestamp: CFTimeInterval = 0.0
    var displayLink: CADisplayLink!;
    var animatingLeft: Bool = false;
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        NSBundle.mainBundle().loadNibNamed("InfinityView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        self.addSubview(contentView)
        
        leftActivity.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), CGFloat(0.0), CGFloat(1.0), CGFloat(0.0));
        
        self.displayLink = CADisplayLink(target: self, selector:Selector("displayRefreshed:"));
        self.displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode:NSRunLoopCommonModes);
    }
    
    func displayRefreshed(dispLink: CADisplayLink) {
        println("dur: \(dispLink.duration) tim: \(dispLink.timestamp)");
        if shouldChangeAnimation(dispLink.timestamp) {
            self.lastAnimationChangeTimestamp = dispLink.timestamp;
            changeAnimation()
        }
    }
    
    func shouldChangeAnimation(timestamp: CFTimeInterval) -> Bool {
        return (timestamp - self.lastAnimationChangeTimestamp) >= 0.95;
    }
    
    func changeAnimation() {
        if animatingLeft {
            self.animateRight()
        } else {
            self.animateLeft()
        }
    }
    
    func animateLeft() {
        self.animatingLeft = true
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.leftActivity.alpha = 1.0
        })
        self.leftActivity.startAnimating()
        self.rightActivity.stopAnimating()
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.rightActivity.alpha = 0.5;
        })
    }
    
    func animateRight() {
        self.animatingLeft = false
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.rightActivity.alpha = 1.0
        })
        self.rightActivity.startAnimating()
        self.leftActivity.stopAnimating()
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.leftActivity.alpha = 0.5;
        })
    }
}
