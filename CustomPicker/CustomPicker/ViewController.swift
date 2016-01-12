//
//  ViewController.swift
//  CustomPicker
//
//  Created by lynn on 16/1/8.
//  Copyright © 2016年 lynn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var provinceData: NSArray!
    var cityData: NSArray!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var dataSource: NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("provinces_cities", ofType: "plist")
        
        let dict = NSDictionary(contentsOfFile: path!)
        self.dataSource = dict
        
        //
        self.provinceData = self.dataSource.allKeys
        
        let selectedProvince = provinceData[0] as! NSString
        self.cityData = self.dataSource[selectedProvince] as! NSArray
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selected(sender: UIButton) {
        
        let row1 = pickerView.selectedRowInComponent(0)
        let row2 = pickerView.selectedRowInComponent(1)
        
        let title = provinceData[row1] as! String + (cityData[row2] as! String) 
        
        cityName.text = title
    }

    // MARK: PickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(component == 0){
            return provinceData.count
        }else{
            return cityData.count
        }
        
    }
    
    //MARK: PickerViewDelegate
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedProvince = provinceData[row] as? String
        if(component == 0){
            cityData = dataSource[selectedProvince!] as! NSArray
            pickerView.reloadComponent(1)
        }else{
            let city = cityData[row] as! String
            cityName.text = selectedProvince! + city
        }
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return  provinceData[row] as? String
        }else{
            return cityData[row] as? String
        }
        
    }
}

