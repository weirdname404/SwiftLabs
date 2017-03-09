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
    let font = UIFont(name: "HelveticaNeue-Bold", size: 45)
    let basicFont = UIFont(name: "System-Regular", size: 25)
    var able = true
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var border: UIImageView!
    
    
    @IBAction func Button1(_ sender: UIButton) {
        if able {
        
            button1.setTitleColor(UIColor.white, for: .normal)
            button1.titleLabel!.font = font
            button1.backgroundColor = greenColor
            button2.backgroundColor = greenColor
            border.backgroundColor = greenColor
            button2.setTitleColor(greenColor, for: .normal)
            able = false
        }
    }
    
    @IBAction func Button2(_ sender: UIButton) {
        if able{
            
            button2.setTitleColor(UIColor.white, for: .normal)
            button2.titleLabel!.font = font
            button2.backgroundColor = redColor
            button1.backgroundColor = redColor
            border.backgroundColor = redColor
            button1.setTitleColor(redColor, for: .normal)
            able = false
        }
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
        
        button1.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        button1.titleLabel!.font = basicFont
        button2.titleLabel!.font = basicFont
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

