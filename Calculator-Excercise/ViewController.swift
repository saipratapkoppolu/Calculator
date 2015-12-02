//
//  ViewController.swift
//  Calculator-Excercise
//
//  Created by Sai Pratap Koppolu on 01/12/15.
//  Copyright © 2015 Sai Pratap Koppolu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation:String {
        
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "clear"
    }
    
    @IBOutlet weak var label: UILabel!
    
    var runningNumber = ""
    var leftStr = ""
    var rightStr = ""
    var currentOperation:Operation = Operation.Empty
    var result = ""
    
    var btnSound : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playSound() {
        btnSound.play()
    }

    @IBAction func onBtnPressed(btn: UIButton) {
        
        playSound()
       
        runningNumber += "\(btn.tag)"
        label.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(currentOperation)
    }
    @IBAction func onClearPressed(sender: UIButton) {
        label.text = "0"
        currentOperation = Operation.Empty
        leftStr = ""
        rightStr = ""
        runningNumber = ""
            }

    
    func processOperation(op:Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            
            
            if runningNumber != "" {
                
                rightStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftStr)! / Double(rightStr)!)"
                }
                
                else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftStr)! * Double(rightStr)!)"
                }
                
                else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftStr)! - Double(rightStr)!)"
                }
                
                else if currentOperation == Operation.Add {
                    result = "\(Double(leftStr)! + Double(rightStr)!)"
                }
                
                
               
                
                leftStr = result
                label.text = result
            }
            currentOperation = op
        }
        else {
            
            leftStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
}

