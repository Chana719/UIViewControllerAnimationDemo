//
//  ViewController.swift
//  UIViewControllerAnimationDemo
//
//  Created by Chana Li on 18/3/16.
//  Copyright © 2016 Chana Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var popBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func popClick(sender: AnyObject){
    
        self.navigationController?.popViewControllerAnimated(true);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

