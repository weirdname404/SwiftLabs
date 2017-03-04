//
//  GameLogic.swift
//  TicTacToe
//
//  Created by Студент on 3/4/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

enum cell: String {
    case empty
    case cross
    case circle
    
    func icon() -> UIImage{
        if let image = UIImage(named: self.rawValue) {
            return image
        } else {
            return #imageLiteral(resourceName: "default")
        }
    }
}

var board: [Int] = []

protocol Player {
    var turn: cell { get }
    var goesFirst: Bool { get }
    
    func move(cellAt: Int)
}

class Computer {
    var turn = cell.circle
    var goesFirst = false
    
    func move(cellAt: Int) {
        board.append(cellAt)
    }
}

class Human {
    var turn = cell.cross
    var goesFirst = true
    
    func move(cellAt: Int) {
        board.append(cellAt)
}

}
