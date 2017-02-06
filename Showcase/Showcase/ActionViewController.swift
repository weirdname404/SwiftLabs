//
//  ActionViewController.swift
//  Showcase
//
//  Created by Студент on 2/1/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    
    @IBOutlet weak var actionControl: UISegmentedControl!
    @IBOutlet weak var showMeButton: UIButton!
    
    @IBAction func performAction(_ sender: Any) {
        if actionControl.selectedSegmentIndex == 0 {
            let controller: UIAlertController = UIAlertController(title: "Hey! You were alerted!",
                                                                  message: "This is an alert!",
                                                                  preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "Ok",
                                                        style: UIAlertActionStyle.default,
                                                        handler: {
                                                            (alert: UIAlertAction!) in controller.dismiss(animated: true,
                                                                                                          completion: nil)})
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
            
        } else {
            let controller: UIAlertController = UIAlertController(title: "Some Action was detected!",
                                                                  message: "You invoked this action",
                                                                  preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let okAction: UIAlertAction = UIAlertAction(title: "Okay.",
                                                        style: UIAlertActionStyle.default,
                                                        handler: {
                                                            (alert: UIAlertAction!) in controller.dismiss(animated: true,
                                                                                                        completion: nil)})
            
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Styling the button
        showMeButton.backgroundColor = UIColor(red: 9/255.0, green: 95/255.0, blue: 134/255.0, alpha: 1.0)
        showMeButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        showMeButton.layer.cornerRadius = 4.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
