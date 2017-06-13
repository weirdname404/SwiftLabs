//
//  ViewController.swift
//  travel-planning_iOs
//
//  Created by Александр Сивцов on 12/02/2017.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    static var storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static var currentUser = ""
    
    
    let api = API()
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func CheckLogIn(_ sender: Any) {
        let userLogin = login.text
        let userPass = password.text
        
        if segmentControl.selectedSegmentIndex == 0 {
            update(login: userLogin!, pass: userPass!)
        }else{
            var loginTextField: UITextField?
            let alertController = UIAlertController(title: "Select Route Id", message: "Enter route name", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.api.routename = (loginTextField?.text!)!
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
                print("Cancel Button Pressed")
            }
            alertController.addAction(ok)
            alertController.addAction(cancel)
            
            alertController.addTextField { (textField) -> Void in
                loginTextField = textField
                loginTextField?.placeholder = "Enter your route name"
            }
            
            
            present(alertController, animated: true, completion: nil)
            
            createNewUser(login: userLogin!, pass: userPass!)
        }
        openMap()

    }
    
    @IBAction func signIn(_ sender: Any) {
        let userLogin = login.text!
        ViewController.currentUser = login.text!
        let userPass = password.text!
        
        //update(login: userLogin!, pass: userPass!)
        if checkCredentials(userLogin, userPass) {
            openMap()
        } else {
            show(.alert, titled: "Cannot sign in", containing: "Username or password is incorrect")
        }
    }
    
    func checkCredentials(_ userLogin: String, _ userPass: String) -> Bool {
        return userLogin == "admin" && userPass == "admin"
    }
    
    func show(_ style: UIAlertControllerStyle, titled title: String, containing message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            (alert:UIAlertAction!) in controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let userLogin = login.text
        let userPass = password.text
        
        var loginTextField: UITextField?
        let alertController = UIAlertController(title: "Select Route Id", message: "Enter route name", preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.api.routename = (loginTextField?.text!)!
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) -> Void in
            print("Cancel Button Pressed")
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextField { (textField) -> Void in
            loginTextField = textField
            loginTextField?.placeholder = "Enter your route name"
        }
        
        
        present(alertController, animated: true, completion: nil)
        
        createNewUser(login: userLogin!, pass: userPass!)
        
        openMap()        
    }
    
    @IBAction func send_request(_ sender: Any) {
        
    }

    func auth()-> Void{
        //var request = URLRequest(url: URL(string: "http://192.168.1.236:1337/checkAuth")!)
        var request = URLRequest(url: URL(string: "http://192.168.43.168:1337/checkAuth")!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                                 return
            }
            
            let jsonArray = try? JSONSerialization.jsonObject(with: data, options:[])
            let t = jsonArray as! NSArray
            
            for index in t {
                print(index)
                let res = index as! NSDictionary
                print(String(describing: res["user_id"]!))
                if(String(describing: res["usertocken"]!) != ""){
                    self.openMap()
                }else{
                    super.viewDidLoad()
                }
            }
        }
        task.resume()
    }
    
    func update(login: String, pass:String)-> Void{
        //var request = URLRequest(url: URL(string: "http://192.168.1.236:1337/auth?login=" + login + "&&pass=" + pass)!)
        
        var request = URLRequest(url: URL(string: "http://192.168.43.168:1337/auth?login=" + login + "&&pass=" + pass)!)
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return
            }
            //self.openMap()
        }
        task.resume()
    }
    
    private func parseDate (data: Any) -> (Data){
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        return jsonData
    }
    
    private func openMap(){
        DispatchQueue.main.async{
                let newViewController = ViewController.storyBoard.instantiateViewController(withIdentifier: "newViewController") as! UITabBarController
                self.present(newViewController, animated: true, completion: nil)
        };
    }
    
    private func createNewUser(login: String, pass:String) -> Void{
        //var request = URLRequest(url: URL(string: "http://192.168.1.236:1337/signIn?login=" + login + "&&pass=" + pass)!)
        var request = URLRequest(url: URL(string: "http://192.168.43.168:1337/signIn?login=" + login + "&&pass=" + pass)!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return
            }
            
        }
        task.resume()
    }


    override func viewDidLoad() {
        self.login.delegate = self
        self.password.delegate = self
        auth()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

