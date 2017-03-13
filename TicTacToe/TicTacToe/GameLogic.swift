//
//  GameLogic.swift
//  TicTacToe
//
//  Created by Студент on 3/4/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

var board: [Int] = []

enum cellSelection: String {
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
