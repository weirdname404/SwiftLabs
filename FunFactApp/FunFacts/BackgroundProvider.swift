//
//  BackgroundProvider.swift
//  FunFacts
//
//  Created by Сергей Лебедев on 03.02.17.
//  Copyright © 2017 Alex Lebedev. All rights reserved.
//

import UIKit
import GameKit

struct BackgroundProvider {
    let colors = [
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
    ]
    
    func randomColor() -> UIColor {
        //random number
        return colors[GKRandomSource.sharedRandom().nextInt(upperBound: colors.count)]
    }
    
    func randomRGBNumber() -> CGFloat {
        return CGFloat(Double(GKRandomSource.sharedRandom().nextInt(upperBound: 255))/255.0)
    }
    
    func newColor() -> UIColor {
        return UIColor(
            red: randomRGBNumber(),
            green: randomRGBNumber(),
            blue: randomRGBNumber(),
            alpha: 1.0)
        
    }
    

}
