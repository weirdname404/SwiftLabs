//
//  ViewController.swift
//  FunFacts
//
//  Created by Сергей Лебедев on 31.01.17.
//  Copyright © 2017 Alex Lebedev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!
    @IBOutlet weak var additionalLabel: UILabel!
    
    let factProvider = FactProvider()
    let colorProvider = BackgroundProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factLabel.text = factProvider.randomFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showFact() {
        factLabel.text = factProvider.randomFact()
        let randomColor = colorProvider.randomColor()
        view.backgroundColor = randomColor
        funFactButton.tintColor = randomColor
    }
    @IBAction func newColor(_ sender: UIButton) {
        let newColor = colorProvider.newColor()
        view.backgroundColor = newColor
        funFactButton.tintColor = newColor
    }
}


