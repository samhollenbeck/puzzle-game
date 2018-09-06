//
//  ViewController.swift
//  Puzzzle Game
//
//  Created by SAMUEL HOLLENBECK on 8/29/18.
//  Copyright © 2018 SAMUEL HOLLENBECK. All rights reserved.
//

import UIKit

//DEFINE INT VARIABLES FOR EACH BOX
var boxOne = 0
var boxTwo  = 0
var boxThree = 0
var boxFour = 0
var boxFive = 0
var boxSix = 0
var boxSeven = 0
var boxEight = 0
var boxNine = 0

//DEFINE MATRIX OF THE INT VARIABLES
let arrayOfBoxes = [[boxOne, boxTwo, boxThree], [boxFour, boxFive, boxSix], [boxSeven, boxEight, boxNine]]

class ViewController: UIViewController {

//DEFINE EACH TEXT FIELD
    @IBOutlet weak var boxOneText: UITextField!
    @IBOutlet weak var boxTwoText: UITextField!
    @IBOutlet weak var boxThreeText: UITextField!
    @IBOutlet weak var boxFourText: UITextField!
    @IBOutlet weak var boxFiveText: UITextField!
    @IBOutlet weak var boxSixText: UITextField!
    @IBOutlet weak var boxSevenText: UITextField!
    @IBOutlet weak var boxEightText: UITextField!
    @IBOutlet weak var boxNineText: UITextField!
    @IBOutlet weak var winLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func formValidation(_ sender: UITextField) {
        print("lol")
        var str = sender.text!
        for char in str {
            if (!isNumber(input: "\(char)")) {
                str = str.replacingOccurrences(of: "\(char)", with: "")
            }
        }
        print(str)
        sender.text = str;
    }
    // CHECKS IF SOULTION IS CORRECT
    @IBAction func checkSolution(_ sender: Any) {
        
        boxOne = Int(boxOneText.text!)!
        boxTwo = Int(boxTwoText.text!)!
        boxThree = Int(boxThreeText.text!)!
        boxFour = Int(boxFourText.text!)!
        boxFive = Int(boxFiveText.text!)!
        boxSix = Int(boxSixText.text!)!
        boxSeven = Int(boxSevenText.text!)!
        boxEight = Int(boxEightText.text!)!
        boxNine = Int(boxNineText.text!)!
        
        var i = 0;
        let value = arrayOfBoxes[i][0] + arrayOfBoxes[i][1] + arrayOfBoxes[i][2];
        var didItWork = true;
        while i <= 2
        {
            if  arrayOfBoxes[i][0] + arrayOfBoxes[i][1] + arrayOfBoxes[i][2] != value
            {
                didItWork = false;
            }
            i = i + 1;
        }
        
        var j = 0;
        while j <= 2
        {
            if  arrayOfBoxes[j][0] + arrayOfBoxes[j][1] + arrayOfBoxes[j][2] != value
            {
                didItWork = false;
            }
            j = j + 1;
        }
        
        if didItWork == true
        {
            winLabel.text = "Correct";
        }
        else
        {
            winLabel.text = "Incorrect";
        }
            
        
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
    func isNumber(input: String) -> Bool {
        
        let num = Int(input)
        if num != nil
        {
            print("Valid Number")
            return true;
        }
        else
        {
            print("Invalid Number");
            winLabel.text = "Make sure all inputs are numbers.";
        }
        return false;
    }
}



