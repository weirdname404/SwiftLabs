//
//  ViewController.swift
//  Reversi
//
//  Created by Александр Лебедев on 20/02/2017.
//  Copyright © 2017 Александр Лебедев. All rights reserved.
//

import UIKit

struct Vec2i {
    var x: Int
    var y: Int
    
    func toTag() -> Int {
        return x * 100 + y
    }
    
    init(tag: Int) {
        x = tag / 100
        y = tag % 100
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    static var offsets: [Vec2i] = [
        Vec2i(x:  0, y:  1),
        Vec2i(x:  0, y: -1),
        Vec2i(x:  1, y:  0),
        Vec2i(x: -1, y:  0),
        
        Vec2i(x:  1, y:  1),
        Vec2i(x: -1, y: -1),
        Vec2i(x:  1, y: -1),
        Vec2i(x: -1, y:  1),
    ]
}

extension Vec2i {
    static func +(left: Vec2i, right: Vec2i) -> Vec2i {
        return Vec2i(x: left.x + right.x, y: left.y + right.y)
    }
    static func -(left: Vec2i, right: Vec2i) -> Vec2i {
        return Vec2i(x: left.x - right.x, y: left.y - right.y)
    }
}


extension Vec2i : Hashable {
    var hashValue: Int {
        return toTag()
    }
    
    static func ==(lhs: Vec2i, rhs: Vec2i) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y;
    }
}


class ViewController: UIViewController {

    var currentButtons : [[UIButton]] = []
    var fieldWidth = 12
    var fieldHeight = 12
    var logic : ReversiLogic!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        logic = ReversiLogic(width: fieldWidth, height: fieldHeight)

        
        
        generateButtonField(xNum: fieldWidth, yNum: fieldHeight, screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
    }
    
    func generateButtonField(xNum: Int, yNum: Int, screenWidth: CGFloat, screenHeight: CGFloat) {
        let maxWidth  = screenWidth  / CGFloat(xNum)
        let maxHeight = screenHeight / CGFloat(yNum)
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
                        button.backgroundColor = UIColor.white
                        button.layer.borderColor = UIColor.gray.cgColor
                    case .Player2:
                        button.backgroundColor = UIColor.black
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
        
        setAvailableButtonColors(color: UIColor.lightGray)
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        clearButtons()
        generateButtonField(xNum: fieldWidth, yNum: fieldHeight, screenWidth: size.width, screenHeight: size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onButtonTouch(_ sender: UIButton) {
        print("button touch \(sender.tag)")
        
        
        let place = Vec2i(tag: sender.tag)
        
        if logic.canStep(at: place) {
            setAvailableButtonColors(color: UIColor.gray)
            switch logic.onStep(at: place) {
            case .Player1:
                sender.backgroundColor = UIColor.white
            case .Player2:
                sender.backgroundColor = UIColor.black
            default:
                break
            }
            
            print("Caputred cells: \(logic.capturedCells)")
            for pos in logic.capturedCells {
                print("FieldAt: \(logic.fieldAt(pos))")
                switch logic.fieldAt(pos) {
                case .Empty:
                    break;
                case .Player1:
                    currentButtons[pos.x][pos.y].backgroundColor = UIColor.white
                    print("Setting white color: \(pos)")
                    break;
                case .Player2:
                    currentButtons[pos.x][pos.y].backgroundColor = UIColor.black
                    print("Setting black color: \(pos)")
                    break;
                }
            }
            
            if logic.isWinState {
                showMessage(text: "\(logic.previousPlayerName()) - the winner", actionText: "Restart")
                newGame()
            } else if logic.isDrawState {
                showMessage(text: "There is no winner in this game", actionText: "Restart")
                newGame()
            }
            
            setAvailableButtonColors(color: UIColor.lightGray)
            
        } else {
            showMessage(text: "Wrong move", actionText: "Try again")
        }
    }
    
    func newGame() {
        logic = ReversiLogic(width: fieldWidth, height: fieldHeight)
        clearButtons()
        generateButtonField(xNum: fieldWidth, yNum: fieldHeight, screenWidth: UIScreen.main.bounds.width, screenHeight: UIScreen.main.bounds.height)
    }
    
    func showMessage(text: String, actionText: String) {
        let controller : UIAlertController = UIAlertController(title: text, message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction : UIAlertAction = UIAlertAction(title: actionText, style: UIAlertActionStyle.default, handler: {
            (alert: UIAlertAction!) in controller.dismiss(animated: true, completion:
                nil) })
        controller.addAction(okAction)
        self.present(controller, animated: true, completion: nil)
    }

}

