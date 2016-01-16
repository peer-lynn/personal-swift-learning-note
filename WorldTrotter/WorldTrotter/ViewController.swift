//
//  ViewController.swift
//  WorldTrotter
//
//  Created by lynn on 16/1/15.
//  Copyright © 2016年 green. All rights reserved.
//

import UIKit

class ConvertionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fahrenheitText:UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue : Double?{
        didSet{
            updateCelsiusValue()
        }
    }
    
    var celsiusValue : Double?{
        if let value = fahrenheitValue{
            return (value - 32) * (5/9)
        }else{
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fahrenheitText.delegate = self
    }
    
    
    @IBAction func fahrenheitTextEditingChange(textfield: UITextField){
        if let text = textfield.text, value = Double(text){
//            celsiusLabel.text = text
            fahrenheitValue = value
        }else{
            celsiusLabel.text = "???"
        }
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject){
        fahrenheitText.resignFirstResponder()
    }
    
    func updateCelsiusValue(){
        if let value = celsiusValue{
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }else{
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty{
            return true
        }
        
        let currentTextHasDecimalSeperator = textField.text?.rangeOfString(".")
        let replaceStringHasDS = string.rangeOfString(".")
        
        
        let mycharset = NSCharacterSet(charactersInString: "-0123456789.")
        
        if currentTextHasDecimalSeperator != nil && replaceStringHasDS != nil{
            return false
        }else{
            let toNSString = string as NSString
            for index in 0 ... toNSString.length - 1 {
                let c = toNSString.characterAtIndex(index)
                if mycharset.characterIsMember(c){
                    return true
                }
            }
        }
        return false
    }
}

