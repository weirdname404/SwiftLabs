//
//  ColorProvider.swift
//  Showcase
//
//  Created by Сергей Лебедев on 06.02.17.
//  Copyright © 2017 HSE. All rights reserved.
//

import GameKit
import UIKit

struct ColorProvider {
    var redColor: CGFloat
    var greenColor: CGFloat
    var blueColor: CGFloat
    
    
    func randomRGBValue() -> CGFloat {
        return CGFloat(Double(GKRandomSource.sharedRandom().nextInt(upperBound: 255))/255.0)
    }
    
    mutating func randomColor() -> UIColor {
        redColor = randomRGBValue()
        greenColor = randomRGBValue()
        blueColor = randomRGBValue()
        
        return UIColor(
            red: redColor,
            green: greenColor,
            blue: blueColor,
            alpha: 1.0)
    }
}

