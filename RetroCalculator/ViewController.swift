//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Mark Rabins on 11/19/16.
//  Copyright © 2016 self.edu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    var buttonSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        counterLabel.text = "0"
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        counterLabel.text = runningNumber
    }
    
    @IBAction func divideButtonPressed(sender: UIButton) {
        processOperation(operation: .Divide)
        
    }
    
    @IBAction func multiplyButtonPressed(sender: UIButton) {
        processOperation(operation: .Multiply)
        
    }
    
    @IBAction func subtractButtonPressed(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addButtonPressed(sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    
    @IBAction func equalsButtonPressed(sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            // A User selected an operator, but then selected another selected without entering a number
            if runningNumber != "" {
                rightValueString = runningNumber
                runningNumber = ""
                
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double (rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double (rightValueString)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString)! - Double (rightValueString)!)"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double (rightValueString)!)"
                    
                }
                leftValueString = result
                counterLabel.text = result
            }
            currentOperation = operation
        } else {
            // This is the first time an operator has been pressed
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

