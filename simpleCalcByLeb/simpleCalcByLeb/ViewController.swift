//
//  ViewController.swift
//  simpleCalcByLeb
//
//  Created by Студент on 1/14/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsTyping: Bool = false
    private var floatingPoint: Bool = false
    
    @IBAction private func pressedDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        switch digit {
        case "." :
            if !floatingPoint {
                display.text = display.text! + digit
                floatingPoint = true
            }
        default  :
            if userIsTyping {
                display.text = display.text! + digit
                
            } else {
                // to replace null
                display.text = digit
            }
        }
        userIsTyping = true
    }
    
    private var displayValue: Double! {
        get {
            return Double(display.text!)
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic() // 1 free init that takes no args
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsTyping {
            calculator.setOperand(operand: displayValue)
            userIsTyping = false
            floatingPoint = false
        }
        
        // if i can let mathSymbol equal to the sender's current title do:
        // if mathSymbol != nil
        
        if let mathSymbol = sender.currentTitle {
            calculator.performOperation(symbol: mathSymbol)
        }

        displayValue = calculator.result
    }
    
    @IBAction func performDelete(_ sender: UIButton) {
        display.text = "0"
        userIsTyping = false
        calculator.setOperand(operand: 0.0)
        calculator.stopWaiting()
    }
}


