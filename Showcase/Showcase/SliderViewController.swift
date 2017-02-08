//
//  SliderViewController.swift
//  Showcase
//
//  Created by Студент on 2/1/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UITextFieldDelegate {
    var redColor: CGFloat = 1.0
    var greenColor: CGFloat = 1.0
    var blueColor: CGFloat = 1.0
    var colorProvider = ColorProvider(redColor: 1.0,
                                      greenColor: 1.0,
                                      blueColor: 1.0)

    @IBOutlet weak var newColorButton: UIButton!
    
    @IBAction func generateNewColor(_ sender: Any) {
        view.backgroundColor = colorProvider.randomColor()
        redColor = colorProvider.redColor
        greenColor = colorProvider.greenColor
        blueColor = colorProvider.blueColor

        
        // Updating text values
        redValue.text = String(format: "%.0f", redColor*255.0)
        greenValue.text = String(format: "%.0f", greenColor*255.0)
        blueValue.text = String(format: "%.0f", blueColor*255.0)
        
        //Updating Sliders' values
        redSlider.value = Float(redColor)
        greenSlider.value = Float(greenColor)
        blueSlider.value = Float(blueColor)
        
    }
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var redValue: UITextField!
    @IBOutlet weak var greenValue: UITextField!
    @IBOutlet weak var blueValue: UITextField!

    @IBAction func changeRed(_ sender: Any) {
        redColor = CGFloat(redSlider.value)
        redValue.text = String(format: "%.0f",Float(redColor*255.0))
        updateColor()
        
    }
    
    @IBAction func changeGreen(_ sender: Any) {
        greenColor = CGFloat(greenSlider.value)
        greenValue.text = String(format: "%.0f",Float(greenColor*255.0))
        updateColor()
        
    }
    
    @IBAction func changeBlue(_ sender: Any) {
        blueColor = CGFloat(blueSlider.value)
        blueValue.text = String(format: "%.0f",Float(blueColor*255.0))
        updateColor()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting the delegate property of the text fields in order to use the UITextViewDelegate protocol.
        redValue.delegate = self
        greenValue.delegate = self
        blueValue.delegate = self
        
        if let colorData = UserDefaults.standard.object(forKey: "colors") as! Array<Double>? {
            redSlider.value = Float(colorData[0])
            greenSlider.value = Float(colorData[1])
            blueSlider.value = Float(colorData[2])
            changeRed(sender: self)
            changeGreen(sender: self)
            changeBlue(sender: self)
        } else {
            UserDefaults.standard.set([1.0, 1.0, 1.0], forKey: "colors")
        }
        
        updateColor()
        
        // Styling the button
        newColorButton.backgroundColor = UIColor(red: 9/255.0, green: 95/255.0, blue: 134/255.0, alpha: 1.0)
        newColorButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        newColorButton.layer.cornerRadius = 4.0

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func updateColor() {
        self.view.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        UserDefaults.standard.set([redSlider.value, greenSlider.value, blueSlider.value], forKey: "colors")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

