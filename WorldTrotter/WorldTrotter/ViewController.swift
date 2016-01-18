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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "a HH:mm"
        let dateString = dateFormatter.stringFromDate(date)
        let timeIdentifier = dateString.rangeOfString("PM")
        
        if timeIdentifier != nil{
            view.backgroundColor = UIColor.blackColor()
        }else{
            view.backgroundColor = UIColor.whiteColor()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fahrenheitText.delegate = self
    }
    
    
    @IBAction func fahrenheitTextEditingChange(textfield: UITextField){
//        if let text = textfield.text, value = Double(text){
        if let text = textfield.text, number = numberFormatter.numberFromString(text){
//            celsiusLabel.text = text
//            fahrenheitValue = value
            fahrenheitValue = number.doubleValue
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
        
        
        let currentLocale = NSLocale.currentLocale()
        let decimalSeperator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        
        let currentTextHasDecimalSeperator = textField.text?.rangeOfString(decimalSeperator)
        let replaceStringHasDS = string.rangeOfString(decimalSeperator)
       
        let charset = "-0123456789" + decimalSeperator
        
        let mycharset = NSCharacterSet(charactersInString: charset)
        
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

