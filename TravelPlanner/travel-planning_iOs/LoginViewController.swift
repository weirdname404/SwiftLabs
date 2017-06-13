//
//  LoginViewController.swift
//  travel-planning_iOs
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    private var loginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginField.delegate = self
        self.passwordField.delegate = self
        
        if loginController.checkAuth() {
            goNext()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onSignInButtonClicked(_ sender: Any) {
        if loginController.auth(login: loginField.text!, password: passwordField.text!) {
            goNext()
        } else {
            show(.alert, titled: "Login failed", containing: "Something went wrong. Try again later.")
        }
    }
    
    private func goNext() {
        performSegue(withIdentifier: "loginPerformed", sender: self)
    }
    
    private func show(_ style: UIAlertControllerStyle, titled title: String, containing message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            (alert:UIAlertAction!) in controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
}
