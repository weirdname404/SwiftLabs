//
//  ViewController.swift
//  TicTacToe
//
//  Created by Александр Лебедев on 20/02/2017.
//  Copyright © 2017 Александр Лебедев. All rights reserved.
//

import UIKit
import SocketIO


class ViewController: UIViewController {
    
    let socket = SocketIOClient(socketURL: URL(string: "http://192.168.1.236:1337/")!, config: [.log(true)])
    
    @IBOutlet weak var competitorId: UILabel!
    var tttLogic = TicaTacToeLogic()
    var competitor: String = ""

    var stopValue: Int = 0;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.on("connect") {data, ack in
            
        }
        
        socket.on("sendCompetitorsId") {data, ack in
            
            for case let button as UIButton in self.view.subviews {
                if button.currentTitle! == String(describing: data[0]){
                    
                    if self.tttLogic.checkNextStep(step: Int(button.currentTitle!)!) {
                        self.nextStep(sender: button)
                        self.stopValue = 0
                    }
                    
                }
            }
        }
        
        socket.on("newGame"){data in
            
            self.res()
        }
        
        socket.on("stop"){data in
            self.stopValue = 1
        }
        
        socket.on("getCompetitorsId") {data, ack in
            print(data[0])
        }

        socket.connect()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func qwerty(_ sender: UIButton, forEvent event: UIEvent) {
        checkTheStep(sender: sender)
    }
    
    private func checkTheStep(sender: UIButton){
            if tttLogic.checkNextStep(step: Int(sender.currentTitle!)!) {
                if self.stopValue == 0 {
                    socket.emit("getCompetitorsId", sender.currentTitle!)
                    self.nextStep(sender: sender)
                    self.stopValue = 1

                }
            }
    }
    
    private func showAlert(text: String){
        let alert = UIAlertController(title: "Alert", message: String(text), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.restartGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func nextStep (sender: UIButton) {
        let message: String = tttLogic.setValue(step: Int(sender.currentTitle!)!)
        if message == "next step"{
            switch tttLogic.currentStep{
            case 0:
                sender.setImage(UIImage(named: "cancel"), for: .normal)
                tttLogic.currentStep = 1
            case 1:
                sender.setImage(UIImage(named: "zero"), for: .normal)
                tttLogic.currentStep = 0
            default:
                break;
            }
        }else{
            showAlert(text: message)
            restartGame()
        }
    }
    
    private func restartGame(){
        socket.emit("newGame")
        self.res()
    }
    
    private func res(){
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.setImage(UIImage(named: "whitePlace"), for: .normal)
            }
        }
        tttLogic.resetFieldsValue()
    }

    @IBOutlet weak var message: UILabel!
    @IBAction func getUserId(_ sender: UIButton) {
        socket.connect()
        
    }

    
}

