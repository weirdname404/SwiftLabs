//
//  TicaTacToeLogic.swift
//  TicTacToe
//
//  Created by Александр Лебедев on 20/02/2017.
//  Copyright © 2017 Александр Лебедев. All rights reserved.
//

import Foundation
import UIKit
import SocketIO


class TicaTacToeLogic {

//    let socket = SocketIOClient(socketURL: URL(string: "http://192.168.1.236:1337/")!, config: [.log(true)])
    // 0 - cross, 1 - zero, 2 - empty
    var currentStep: Int = 0
    private var field = Array(repeating: 2, count: 9)
    

    public func connect()  {
        
        
    }
    
    public func checkStep(step: Int){
        switch step {
        case 0:
            currentStep = 1
        case 1:
            currentStep = 0
        default:
            currentStep = 0
            break;
        }
    }
    
    public func checkNextStep(step: Int) -> Bool{
        return field[step] == 2
    }
    
    public func setValue(step: Int) -> String{
        
        field[step] = currentStep
        let winner: Int = checkWinRate(number: step)
        if winner != 2 {
            switch winner {
            case 0:
                return "cross win"
            case 1:
                return "zero win"
            default:
                return "next step"
            }
        }else{
            return "next step"
        }
    }
    
    public func resetFieldsValue(){
        field = Array(repeating: 2, count: 9)
    }
    
    
    
    //плохая функция, можно переписать но пока не успеваю
    private func checkWinRate(number: Int) -> Int {
        
        if (field[0] == field[1] && field[1] == field[2] && field[0] != 2 && field[1] != 2 && field[2] != 2) {
            return currentStep
        }else if (field[3] == field[4] && field[4] == field[5] && field[3] != 2 && field[4] != 2 && field[5] != 2) {
            return currentStep
        }
        if (field[6] == field[7] && field[7] == field[8] && field[6] != 2 && field[7] != 2 && field[8] != 2) {
            return currentStep
        }else if (field[0] == field[4] && field[4] == field[8] && field[0] != 2 && field[4] != 2 && field[8] != 2) {
            return currentStep
        }else if (field[2] == field[4] && field[4] == field[6] && field[2] != 2 && field[4] != 2 && field[6] != 2) {
            return currentStep
        }else if (field[0] == field[3] && field[3] == field[6] && field[0] != 2 && field[3] != 2 && field[6] != 2) {
            return currentStep
        }else if (field[1] == field[4] && field[4] == field[7] && field[1] != 2 && field[4] != 2 && field[7] != 2) {
            return currentStep
        }else if (field[2] == field[5] && field[5] == field[8] && field[2] != 2 && field[5] != 2 && field[8] != 2) {
            return currentStep
        }else {
            return 2
        }
    }
    
    
    
}
