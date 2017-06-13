//
//  cell.swift
//  Reversi
//
//  Created by Александр Сивцов on 31/05/2017.
//  Copyright © 2017 HSE. All rights reserved.
//

import Foundation

class Cell {
    var currentButtons : [[UIButton]] = []
    
    func generateButtonField(xNum: Int, yNum: Int, screenWidth: CFloat?, screenHeight: CGFloat) {
        let maxWidth  = screenWidth!  / (CFloat(xNum))
        let maxHeight = screenHeight / (CFloat(yNum))
        let buttonSize = min(maxWidth, maxHeight)
        
        currentButtons = (0..<yNum).map {
            ix in (0..<xNum).map {
                iy in {
                    let button = UIButton(type: .custom)
                    view.addSubview(button)
                    button.tag = 100 * ix + iy
                    switch logic.fieldAt(Vec2i(tag: button.tag)) {
                    case .Empty:
                        button.backgroundColor = UIColor.gray
                        button.layer.borderColor = UIColor.gray.cgColor
                    case .Player1:
                        button.backgroundColor = UIColor.green
                        button.layer.borderColor = UIColor.gray.cgColor
                    case .Player2:
                        button.backgroundColor = UIColor.red
                        button.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                    button.layer.borderWidth = 10
                    
                    button.layer.cornerRadius = 0
                    
                    button.frame = CGRect(x: CGFloat(ix) * buttonSize, y: CGFloat(iy) * buttonSize, width: buttonSize, height: buttonSize)
                    
                    button.addTarget(self, action: #selector(ViewController.onButtonTouch(_:)), for: .touchUpInside)
                    
                    return button
                }()
            }
        }
        
        setAvailableButtonColors(color: UIColor.white)
    }
    
    
    
    func setAvailableButtonColors(color: UIColor) {
        for pos in logic.availableCells {
            currentButtons[pos.x][pos.y].backgroundColor = color
        }
    }
    
    func clearButtons() {
        for row in currentButtons {
            for button in row {
                button.removeFromSuperview()
            }
        }
        currentButtons.removeAll()
    }
}
