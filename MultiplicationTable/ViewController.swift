//
//  ViewController.swift
//  MultiplicationTable
//
//  Created by John N Blanchard on 1/23/16.
//  Copyright © 2016 John N Blanchard. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet var timesTableButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var responseLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var selectButtonPressed: UIButton!
    @IBOutlet var backgroundImageView: UIImageView!
    
    
    var selectedRow : Int = 0
    var answer : Int = 0
    var pickerDataSource : Array<Int> = []
    var timesTableArray : Array<Int> = [2,3,4,5,6,7,8,9,10]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        setUpPickerViewData()
        setQuestion()
    }
    
    func createTimesTable(newMax: Int)
    {
        timesTableArray = []
        for num in 2...newMax
        {
            timesTableArray.append(num)
        }
        timesTableButton.setTitle("Max Number: \(timesTableArray.last!)", forState: UIControlState.Normal)
        
    }
    
    func setUpPickerViewData()
    {
        pickerDataSource += 2...100
    }
    
    func setQuestion()
    {
        answerLabel.text = ""
        let randomIndexOne = Int(arc4random_uniform(UInt32(timesTableArray.count)))
        let randomIndexTwo = Int(arc4random_uniform(UInt32(timesTableArray.count)))
        answer = timesTableArray[randomIndexOne] * timesTableArray[randomIndexTwo]
        self.questionLabel.text = "\(timesTableArray[randomIndexOne]) x \(timesTableArray[randomIndexTwo]) = "
    }
    
    @IBAction func timesTableButtonPressed(sender: AnyObject)
    {
        view.bringSubviewToFront(pickerView)
        view.bringSubviewToFront(selectButtonPressed)
        pickerView.hidden = false
        selectButtonPressed.hidden = false
    }
    
    @IBAction func deleteButtonPressed(sender: AnyObject)
    {
        if (((answerLabel.text?.isEmpty) == false))
        {
            var newLabelString = answerLabel.text! as String
            newLabelString.removeAtIndex(newLabelString.endIndex.predecessor())
            answerLabel.text = newLabelString
        }
    }
    
    @IBAction func enterButtonPressed(sender: AnyObject)
    {
        let theirAnswer = Int(answerLabel.text!)
        if (answer == theirAnswer)
        {
            responseLabel.text = "Correct"
            responseLabel.backgroundColor = UIColor.greenColor()
            setQuestion()
        } else
        {
            responseLabel.text = "Incorrect"
            responseLabel.backgroundColor = UIColor.redColor()
        }
        responseLabel.hidden = false
        answerLabel.text = ""
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            self.responseLabel.hidden = true
        }
    }

    @IBAction func numberButtonPressed(sender: UIButton)
    {
        let num = sender.titleLabel?.text
        answerLabel.text?.appendContentsOf(num!)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return "\(pickerDataSource[row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectButtonPressed.setTitle("Pick \(pickerDataSource[row]) by \(pickerDataSource[row]) table", forState: UIControlState.Normal)
        selectedRow = pickerDataSource[row]
    }
    
    
    @IBAction func selectButtonPressed(sender: AnyObject)
    {
        selectButtonPressed.hidden = true
        pickerView.hidden = true
        answerLabel.text = ""
        createTimesTable(selectedRow)
        setQuestion()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

