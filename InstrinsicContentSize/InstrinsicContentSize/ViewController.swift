//
//  ViewController.swift
//  InstrinsicContentSize
//
//  Created by lynn on 16/1/11.
//  Copyright © 2016年 lynn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        let button1 = UIButton.init(type: UIButtonType.RoundedRect)
        
        button1.translatesAutoresizingMaskIntoConstraints = false;
        button1.setTitle("button 1 button 2", forState: .Normal)
        button1.sizeToFit()
        
        self.view.addSubview(button1)
        
        var constraint = NSLayoutConstraint(item: button1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 100.0)
        
        self.view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: button1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 100.0)
        self.view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: button1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -200.0)
        
        constraint.priority = 749.0
        self.view.addConstraint(constraint)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

