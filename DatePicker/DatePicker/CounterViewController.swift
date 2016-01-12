//
//  CounterViewController.swift
//  DatePicker
//
//  Created by lynn on 16/1/8.
//  Copyright © 2016年 lynn. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {

    var timeLabel: UILabel?
    var timeButtons: [UIButton]?
    var startStopButton: UIButton?
    var clearButton: UIButton?
    
    var isCounting:Bool = false{
        willSet(newValue){
            if newValue{
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
            }else{
                timer?.invalidate()
                timer = nil
            }
            setSettingButtonEnabled(!newValue)
        }
    }
    
    var timer: NSTimer?
    
    var remainingSeconds: Int = 0{
        willSet(newSeconds){
            let mins = newSeconds/60
            let seconds = newSeconds%60
            self.timeLabel!.text = NSString(format: "%02d:%02d", mins, seconds) as String
        }
    }
    
    let timeButtonInfoes = [("一分", 60), ("三分", 180), ("五分", 300), ("秒", 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTimeLabel()
        setupTimeButtons()
        setupActionButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        timeLabel?.frame = CGRectMake(10, 40, self.view.bounds.width - 20, 120)
        
        let gap = (self.view.bounds.size.width - 10*2 - (CGFloat(timeButtons!.count) * 64)) / CGFloat(timeButtons!.count - 1)
        
        for(index, butotn) in (timeButtons?.enumerate())!{
            let buttonLeft = 10 + (64 + gap) * CGFloat(index)
            butotn.frame = CGRectMake(buttonLeft, self.view.bounds.height - 120, 64, 44)
            
        }
        
        startStopButton!.frame = CGRectMake(10, self.view.bounds.height - 60, self.view.bounds.width-20-100, 44)
        clearButton!.frame = CGRectMake(10 + self.view.bounds.size.width-20-100+20, self.view.bounds.size.height - 60, 80, 44)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UI Helpers
    func setupTimeLabel(){
        timeLabel = UILabel()
//        timeLabel?.frame = CGRect(x: 0, y: 0, width: 240, height: 50)
        timeLabel!.text = "00:00"
        timeLabel?.textColor = UIColor.whiteColor()
        timeLabel?.font = UIFont(name: "", size: 80)
        timeLabel?.backgroundColor = UIColor.blackColor()
        timeLabel?.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(timeLabel!)
    }

    func setupTimeButtons(){
        var buttons = [UIButton]()
        for(index, (title, _)) in timeButtonInfoes.enumerate(){
            let button: UIButton = UIButton()
            button.tag = index
            button.setTitle("\(title)", forState: UIControlState.Normal)
            button.backgroundColor = UIColor.orangeColor()
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
            button.addTarget(self, action: "timeButtonTapped", forControlEvents: .TouchUpInside)
            
            buttons += [button]
            self.view.addSubview(button)
        }
        timeButtons = buttons
    }
    
    func setupActionButtons(){
        startStopButton = UIButton()
        startStopButton!.backgroundColor = UIColor.redColor()
        startStopButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        startStopButton!.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        startStopButton!.setTitle("启动/停止", forState: .Normal)
        
        startStopButton!.addTarget(self, action: "startstopButtonTapped", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(startStopButton!)
        
        clearButton = UIButton()
        clearButton?.backgroundColor = UIColor.redColor()
        clearButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        clearButton!.setTitleColor(UIColor.blackColor(), forState: .Normal)
        clearButton!.setTitle("复位", forState: .Normal)
        
        clearButton!.addTarget(self, action: "clearButtonTapped", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(clearButton!)
        
    }
    
    
    func clearButtonTapped(sender: UIButton){
       remainingSeconds = 0
    }
    
    func startstopButtonTapped(sender: UIButton){
        isCounting = !isCounting
    }
    
    func timeButtonTapped(sender: UIButton){
        
        let (_, seconds) = timeButtonInfoes[sender.tag]
        remainingSeconds += seconds
    }
    
    
    
    // MARK: update timer
    func updateTimer(timer: NSTimer){
        remainingSeconds -= 1
        
        if remainingSeconds <= 0{
            self.isCounting = false
            self.timeLabel?.text = "00.00"
            self.remainingSeconds = 0
            
            let alert = UIAlertView()
            
            alert.title = "计时完成"
            alert.message = ""
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    
    func setSettingButtonEnabled(enabled: Bool){
        for button in timeButtons!{
            button.enabled = enabled
            button.alpha = enabled ? 1.0: 0.3
        }
        
        clearButton!.enabled = enabled
        clearButton!.alpha = enabled ? 1.0 : 0.3
    }
    
    
    
}
