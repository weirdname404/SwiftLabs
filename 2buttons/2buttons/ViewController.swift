//
//  ViewController.swift
//  2buttons
//
//  Created by Студент on 3/9/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let greenColor = UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
    let redColor =  UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0)
    let grayColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
    let font = UIFont(name: "HelveticaNeue-Bold", size: 120)
    let basicFont = UIFont(name: "HelveticaNeue-Light", size: 90)
    var able = true
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var border: UIImageView!

    func changeColor(button1: UIButton, button2: UIButton, color: UIColor) {
        button1.setTitleColor(UIColor.white, for: .normal)
        button1.titleLabel!.font = font
        button1.backgroundColor = color
        button2.backgroundColor = color
        border.backgroundColor = color
        button2.setTitleColor(color, for: .normal)
        able = false
    }
    
    
    @IBAction func Button1(_ sender: UIButton) {
        if able {
            changeColor(button1: button1, button2: button2, color: greenColor)
            
        } else {
            newGame()
        }
    }


    @IBAction func turnButton1(_ sender: Any) {
        turnButton(button1)
        print("1")

    }

    @IBAction func Button2(_ sender: UIButton) {
        if able{
            changeColor(button1: button2, button2: button1, color: redColor)
            
        } else {
            newGame()
        }
    }
    

    @IBAction func turnButton2(_ sender: Any) {
        turnButton(button2)
        print("2")
    }

    
//    func longTap(sender: UIGestureRecognizer) {
//        if sender.state == .ended {
//            if sender == button1 {
//                turnButton(button: button1)
//            }}
//    }
    
    func turnButton(_ button: UIButton) {
        button.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
    }
    
    func newGame() {
        able = true
        button1.setTitleColor(greenColor, for: .normal)
        button2.setTitleColor(redColor, for: .normal)
        
        button1.backgroundColor = UIColor.white
        button2.backgroundColor = UIColor.white
        
        border.backgroundColor = grayColor
        
        button1.titleLabel!.font = basicFont
        button2.titleLabel!.font = basicFont
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button1.titleLabel!.font = basicFont
        button2.titleLabel!.font = basicFont
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: Selector(("normalTap")))
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: Selector(("longTap")))
//        
//        tapGesture.numberOfTapsRequired = 1
//        
//        button1.addGestureRecognizer(longPressGesture)
//        button1.addGestureRecognizer(tapGesture)
//        
//        button2.addGestureRecognizer(longPressGesture)
//        button2.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            newGame()
        }
    }
}

