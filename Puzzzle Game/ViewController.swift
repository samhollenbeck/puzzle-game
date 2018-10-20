//
//  ViewController.swift
//  Puzzzle Game
//
//  Created by SAMUEL HOLLENBECK on 8/29/18.
//  Copyright © 2018 SAMUEL HOLLENBECK. All rights reserved.
//

import UIKit

var mode = "regular"

var boxOne = 0
var boxTwo  = 0
var boxThree = 0
var boxFour = 0
var boxFive = 0
var boxSix = 0
var boxSeven = 0
var boxEight = 0
var boxNine = 0

var gameTimerExtreme: Timer!

var isFieldInChallengeMode = [[false, false, false], [false, false, false], [false, false, false]]

var arrayOfBoxes = [[boxOne, boxTwo, boxThree], [boxFour, boxFive, boxSix], [boxSeven, boxEight, boxNine]]

var arrayOfTextField = [[UITextField?]]()

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
    @IBOutlet weak var currentMode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // CHECKS IF SOULTION IS CORRECT
    @IBAction func checkSolution(_ sender: Any) {
        checkSolution()
    }
    
    func checkSolution() {
        
        if mode == "extreme"
        {
            gameTimerExtreme.invalidate()
        }
        
        //ASSIGN TEXTFIELD VALUES TO INT VARIABLES
        boxOne = Int(boxOneText.text!)!
        boxTwo = Int(boxTwoText.text!)!
        boxThree = Int(boxThreeText.text!)!
        boxFour = Int(boxFourText.text!)!
        boxFive = Int(boxFiveText.text!)!
        boxSix = Int(boxSixText.text!)!
        boxSeven = Int(boxSevenText.text!)!
        boxEight = Int(boxEightText.text!)!
        boxNine = Int(boxNineText.text!)!
        
        let arrayOfBoxes = [[boxOne, boxTwo, boxThree], [boxFour, boxFive, boxSix], [boxSeven, boxEight, boxNine]]
        
        var i = 0;
        //MAKES SURE ALL ROWS MATCH VALUE OF FIRST ROW
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
        
        //MAKES SURE ALL COLS MATCH VALUE OF FIRST ROW
        var j = 0;
        while j <= 2
        {
            if  arrayOfBoxes[j][0] + arrayOfBoxes[j][1] + arrayOfBoxes[j][2] != value
            {
                didItWork = false;
            }
            j = j + 1;
        }
        
        //DISPLAYS IF SOLUTION WAS CORRECT
        if didItWork == true
        {
            winLabel.text = "Correct";
        }
        else
        {
            winLabel.text = "Incorrect";
        }
    }
    
    //SWITCH GAME MODES - CALLED BY BUTTON ON STORYBOARD
    @IBAction func switchModes(_ sender: Any) {
        
        if mode == "regular"
        {
            mode = "challenge"
            currentMode.text = "Current Mode: Challenge"
            clearFields()
        }
        else if mode == "challenge"
        {
            mode = "extreme"
            currentMode.text = "Current Mode: Extreme"
            clearFields()
        }
        else
        {
            mode = "regular"
            currentMode.text = "Current Mode: Regular"
            gameTimerExtreme.invalidate()
            clearFields()
        }
    }
    
    //RANDOMLY ASSIGNS VALUES TO FIELDS
    func challengeMode() {
        
        arrayOfTextField = [[boxOneText, boxTwoText, boxThreeText], [boxFourText, boxFiveText, boxSixText], [boxSevenText, boxEightText, boxNineText]]
        
        var i = 0
        while i <= 2
        {
            let x = Int(arc4random_uniform(3))
            let y = Int(arc4random_uniform(3))
            let num = Int(arc4random_uniform(16) + 1)
            
            if isFieldInChallengeMode[x][y] == true
            {
                continue;
            }
            
            //CREATE REFERENCE TO SPECIFIC TEXTFIELD
            let textField = arrayOfTextField[x][y];
            
            //ASSIGN THE FIELD AS BEING IN CHALLENGE MODE (UNEDITABLE)
            isFieldInChallengeMode[x][y] = true;
            
            //PUT RANDOMLY GENERATED NUMBER INTO FIELD AND MAKE IT BOLD
            textField!.text = String(num);
            textField!.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
            
            arrayOfBoxes[x][y] = num;
            i = i + 1
        }
    }
    
    func extremeMode(){
        
        //CREATE RANDOMIZED UNEDITABLE NUMBERS IN FIELDS
        challengeMode()
        
        //SCRAMBLE THE LOCATION OF CERTAIN VALUES IN FIELDS - CALLS DELETEVALUES() EVERY 3 SECONDS
        gameTimerExtreme = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(deleteValues), userInfo: nil, repeats: true)
    }
    
    @objc func deleteValues(){
        
        var i = 0
        
        while i < 1
        {
            let x = Int(arc4random_uniform(3))
            let y = Int(arc4random_uniform(3))
            
            if isFieldInChallengeMode[x][y] == true
            {
                continue
            }
            
            let textField = arrayOfTextField[x][y];
            //textField!.textColor = UIColor.red
            
            if textField!.text != ""
            {
                replaceFields(num: Int(textField!.text!)!)
            }
            textField!.text = String("")
            //arrayOfBoxes[x][y] = 0
            
            i = 1
        }
    }
    
    //DELETES ANY NON NUMERIC CHARACTERS FROM THE TEXTFIELDS
    @IBAction func formValidation(_ sender: UITextField) {
        var str = sender.text!
        var isNegative = false
        
        //CHECK IF NUMBER IS NEGATIVE
        if str.prefix(1) == "-"
        {
            isNegative = true
        }
        
        //DON'T ALLOW A SINGLE ZERO IN THE FIELD
        if str.prefix(1) == "0"
        {
            str.remove(at: str.startIndex)
        }
        
        //CHECK IF EACH CHARACTER IS A NUMBER
        for char in str {
            if (!isNumber(input: "\(char)")) {
                str = str.replacingOccurrences(of: "\(char)", with: "")
            }
        }
        
        if(isNegative == true)
        {
            str = "-" + str
        }
        
        sender.text = str;
        
        if mode == "challenge" || mode == "extreme"
        {
            enforceUneditableChallengeFields()
        }
    }
    
    //RESTRICTS USER FROM CHANGING THE VALUES IN FIELDS THAT WERE RANDOMLY ASSIGNED VALUES
    func enforceUneditableChallengeFields() {
        
        arrayOfTextField = [[boxOneText, boxTwoText, boxThreeText], [boxFourText, boxFiveText, boxSixText], [boxSevenText, boxEightText, boxNineText]]
        
        for i in 0...2 {
            for j in 0...2 {
                if isFieldInChallengeMode[i][j] == true
                {
                    let textField = arrayOfTextField[i][j];
                    textField!.text = String(arrayOfBoxes[i][j]);
                    
                }
            }
        }
    }
    
    //CHECKS TO SEE IF A STRING CONTAINS ONLY NUMERIC CHARACTERS
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
            //winLabel.text = "Make sure all inputs are numbers.";
        }
        return false;
    }
    
    //CLEARS ALL TEXTFIELDS AND INT VARIABLES
    @IBAction func clearFields(_ sender: Any) {
        clearFields()
    }
    
    func clearFields() {
        
        boxOneText.text = ""
        boxTwoText.text = ""
        boxThreeText.text = ""
        boxFourText.text = ""
        boxFiveText.text = ""
        boxSixText.text = ""
        boxSevenText.text = ""
        boxEightText.text = ""
        boxNineText.text = ""
        winLabel.text = ""
        
        //CLEARS ALL INT VARIABLES
        boxOne = 0
        boxTwo  = 0
        boxThree = 0
        boxFour = 0
        boxFive = 0
        boxSix = 0
        boxSeven = 0
        boxEight = 0
        boxNine = 0
        
        for i in 0...2
        {
            for j in 0...2
            {
                arrayOfBoxes[i][j] = 0
            }
        }
        
        isFieldInChallengeMode = [[false, false, false], [false, false, false], [false, false, false]]
        
        //RECALL GAME METHOD ASED ON CURRENT MODE
        if mode == "regular"{
            regularFont()
        }
        
        if mode == "challenge"{
            challengeMode()
        }
        if mode == "extreme"{
            regularFont()
            extremeMode()
        }

    }
    
    //SET ALL FIELDS BACK TO A REGULAR WEIGHT
    func regularFont() {
        
        for i in 0...2
        {
            for j in 0...2
            {
                let textField = arrayOfTextField[i][j];
                textField!.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
                textField!.textColor = UIColor.black
            }
        }
    }
    
    func replaceFields(num: Int){
        
        print("replaceFields")
        print(num)
        var i = 0
        while i < 1
        {
            let x = Int(arc4random_uniform(3))
            let y = Int(arc4random_uniform(3))
            
            if isFieldInChallengeMode[x][y]
            {
                continue;
            }
            
            let textField = arrayOfTextField[x][y]
            if num != 0{
                //arrayOfBoxes[x][y] = num
                textField!.text = String(num)
                print("test 1")
            }
            i = 1
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
