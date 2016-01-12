//
//  RatingControl.swift
//  CustomControl
//
//  Created by lynn on 16/1/11.
//  Copyright © 2016年 lynn. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var stars = 5
    var ratingButtons = [UIButton]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let emptyStar = UIImage(named: "emptyStar")
        let filledStar = UIImage(named: "filledStar")
        
        for _ in 0..<stars {
            let button = UIButton()
            button.setImage(emptyStar, forState: .Normal)
            button.setImage(filledStar, forState: .Selected)
            button.setImage(filledStar, forState: [.Highlighted,.Selected])
            
            button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchDown)
            
            ratingButtons.append(button)
            addSubview(button)
        }
              
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for(index, button) in ratingButtons.enumerate(){
            buttonFrame.origin.x = CGFloat(index * (buttonSize + 5))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    func buttonTapped(sender: UIButton){
        rating = ratingButtons.indexOf(sender)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates(){
        for (index, buton) in ratingButtons.enumerate(){
            buton.selected = index < rating
        }
    }
}


