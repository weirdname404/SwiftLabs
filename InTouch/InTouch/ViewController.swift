//
//  ViewController.swift
//  InTouch
//
//  Created by Студент on 2/8/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    
    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail()
        {
            let mailVC = MFMailComposeViewController()
            mailVC.setSubject("MySubject")
            mailVC.setToRecipients(["lebedev.alex69@gmail.com"])
            mailVC.setMessageBody("<p>Hello!Hello!Hello!</p>", isHTML: true)
            mailVC.mailComposeDelegate = self;
            
            self.present(mailVC, animated: true, completion: nil)
            
        } else {
            
            print("This device is currently unable to send email")
            
        }
    }

    @IBAction func sendText(_ sender: Any) {
        if MFMessageComposeViewController.canSendText()
        {
    
            let smsVC : MFMessageComposeViewController = MFMessageComposeViewController()
            smsVC.messageComposeDelegate = self
            smsVC.recipients = ["1234500000"]
            smsVC.body = "Please call me back."
            self.present(smsVC, animated: true, completion: nil)
            
        } else {
            
            print("This device is currently unable to send text messages")
        }
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://hse.ru")!, options: [:], completionHandler: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mailComposeController(_ didFinishWithcontroller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: NSError?) {
        
        switch result {
        case MFMailComposeResult.sent:
            print("Result: Email Sent!")
            
        case MFMailComposeResult.cancelled:
            print("Result: Email Cancelled.")
            
        case MFMailComposeResult.failed:
            print("Result: Error, Unable to Send Email.")
            
        case MFMailComposeResult.saved:
            print("Result: Mail Saved as Draft.")
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        
        switch result {
        case MessageComposeResult.sent:
            print("Result: Text Message Sent!")
            
        case MessageComposeResult.cancelled:
            print("Result: Text Message Cancelled.")
            
        case MessageComposeResult.failed:
            print("Result: Error, Unable to Send Text Message.")
            
        }
        
        self.dismiss(animated:true, completion: nil)
        
    }
}

