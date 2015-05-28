//
//  ViewController.swift
//  Thing3
//
//  Created by Ostap Horbach on 5/15/15.
//  Copyright (c) 2015 Ostap Horbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infinityView: InfinityView!
    @IBOutlet weak var deltaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.infinityView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

