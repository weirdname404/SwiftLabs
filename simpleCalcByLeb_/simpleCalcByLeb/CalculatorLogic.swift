//
//  CalculatorLogic.swift
//  simpleCalcByLeb
//
//  Created by Студент on 1/16/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import Foundation

class CalculatorLogic {
    
    private var accumulatingNumber = 0.0
    
    func setOperand(operand: Double){
        accumulatingNumber = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        
        "π"   : Operation.Constant(M_PI),
        "√"   : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "×"   : Operation.BinaryOpearion({ $0 * $1 }),  // closure (inline functions) + default args
        "÷"   : Operation.BinaryOpearion({ $0 / $1 }),
        "+"   : Operation.BinaryOpearion({ $0 + $1 }),
        "−"   : Operation.BinaryOpearion({ $0 - $1 }),
        "="   : Operation.Equals
    ]
    
    // new type, a discrete set of values
    // It can be 1 of 4 types
    private enum Operation {
        case Constant(Double) // (associated value)
        case UnaryOperation((Double) -> Double) // associated with func
        case BinaryOpearion((Double, Double) -> Double) // a + b; a * b
        case Equals
    }
    
    private var pressedSymbol: String = ""
    
    func performOperation(symbol: String) {
        pressedSymbol = symbol
        if let operation = operations[symbol] {
            switch operation {
                
            case .Constant(let value):
                accumulatingNumber = value
                
            case .BinaryOpearion(let function):
                executeAwaitingBinaryOperation()
                isWaiting = AwaitingBinaryOperation(binaryFunction: function, firstOperand: accumulatingNumber)
                
            case .UnaryOperation(let function):
                accumulatingNumber = function(accumulatingNumber)
                
            case .Equals:
                executeAwaitingBinaryOperation()
            }
        }
    }
    
    private func changeMathSymbol() {
        
    }
    
    private func executeAwaitingBinaryOperation() {
        if isWaiting != nil {
            accumulatingNumber = isWaiting!.binaryFunction(isWaiting!.firstOperand, accumulatingNumber)
        }
        if pressedSymbol == "=" {
            stopWaiting()
        }
    }
    
    public func stopWaiting() { // func is not used
        isWaiting = nil
    }
    
    public var isWaiting: AwaitingBinaryOperation? // it can be nil
    
    
    // type which is passed by values (copies it)
    public struct AwaitingBinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulatingNumber
        }
    }
    
}



