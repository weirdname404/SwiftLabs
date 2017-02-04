//
//  MessageViewController.swift
//  ShowMe App
//
//  Created by Студент on 1/25/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    var messageData: String?
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Do any additional setup after loading the view.
        messageLabel.text = messageData
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
