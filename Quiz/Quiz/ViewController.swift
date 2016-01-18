//
//  ViewController.swift
//  Quiz
//
//  Created by lynn on 16/1/15.
//  Copyright © 2016年 iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var currentQuestionLabel:UILabel!
    @IBOutlet weak var nextQuestionLabel:UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    let questionList:[String] = ["what is 7+7", "how do you do", "how mang apple in  the basket"]
    
    let answerList: [String] = ["14", "fine", "13"]
    
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionLabel.text = questionList[currentQuestionIndex]
    }
    @IBAction func showNextQuestion(sender: UIButton){
        
        ++currentQuestionIndex
        if currentQuestionIndex == questionList.count{
            currentQuestionIndex = 0
        }
        nextQuestionLabel.text = questionList[currentQuestionIndex]
        
        animateLabelTranslation()
    }
    
    @IBAction func showAnswer(sender: AnyObject?){
        answerLabel.text = answerList[currentQuestionIndex]
    }
    
    func animateLabelTranslation() {
        
        UIView.animateWithDuration(0.5, delay: 0, options: [], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            }, completion: {
                _ in swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
}

