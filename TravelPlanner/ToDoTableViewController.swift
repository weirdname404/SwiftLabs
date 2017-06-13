//
//  ToDoTableViewController.swift
//  travel-planning_iOs
//
//  Created by Студент on 5/20/17.
//  Copyright © 2017 Александр Лебедев. All rights reserved.
//

import UIKit



class ToDoTableViewController: UITableViewController {
    
    static var DATA = [Task_Data]()
    static var status: Bool = false
    static var current_key = String()
    
    var COUNTER = 0
    
    let reuseIdentifier = "cell"
    
    let api = API()
    let mapVC = MapViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getListData(trip_name: api.routename)
    }
    
//    func getListData(trip_name: String)-> Void{
//        //var request = URLRequest(url: URL(string: "http://192.168.1.236:1337/getListData?trip_name=" + trip_name)!)
//        var request = URLRequest(url: URL(string: "http://192.168.43.168:1337/getListData?trip_name=" + trip_name)!)
//        request.httpMethod = "POST"
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                                 return
//            }
//            
//            let jsonArray = try? JSONSerialization.jsonObject(with: data, options:[])
//            let t = jsonArray as! NSArray
//            print(t)
//            for index in t {
//                print(index)
//                let res = index as! NSDictionary
//                DATA.append(res["whatyouneed"]! as! String)
//            }
//            
//
//        }
//        task.resume()
//    }
//
//    func delListData(element: String)-> Void{
//        //var request = URLRequest(url: URL(string: "http://192.168.1.236:1337/delListData?element=" + element)!)
//        
//        let query = URL(string: "http://192.168.43.168:1337/delListData?element=" + element.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!
//        var request = URLRequest(url: query)
//        request.httpMethod = "POST"
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let _ = data, error == nil else {                                                                 return
//            }
//        }
//        task.resume()
//    }
//
//    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ToDoTableViewController.DATA.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = ToDoTableViewController.DATA[indexPath.row].task_name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller: UIAlertController = UIAlertController(title: "",
                                                              message: "",
                                                              preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let showAction: UIAlertAction = UIAlertAction(title: "Show On Map",
                                                      style: UIAlertActionStyle.default,
                                                      handler: { (action) -> Void in
                                                        DispatchQueue.main.async{
                                                            let newViewController = ViewController.storyBoard.instantiateViewController(withIdentifier: "newViewController") as! UITabBarController
                                                            self.present(newViewController, animated: true, completion: nil)
                                                            
                                                        };})
        
        let okAction: UIAlertAction = UIAlertAction(title: "Ok",
                                                    style: UIAlertActionStyle.default,
                                                    handler: {
                                                        (alert: UIAlertAction!) in controller.dismiss(animated: true,
                                                                                                      completion: nil)})
        
        let titleFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "ArialRoundedMTBold", size: 24)! ]
        let messageFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "EuphemiaUCAS", size: 18)! ]
        let attributedTitle = NSMutableAttributedString(string: ToDoTableViewController.DATA[indexPath.row].task_name, attributes: titleFont)
        let attributedMessage = NSMutableAttributedString(string: "Detailed description:\n\(ToDoTableViewController.DATA[indexPath.row].task_description)\nTask was added: \(ToDoTableViewController.DATA[indexPath.row].task_date) \nby \(ToDoTableViewController.DATA[indexPath.row].user_name)\nThe deadline is \(ToDoTableViewController.DATA[indexPath.row].task_deadline)", attributes: messageFont)
        controller.setValue(attributedTitle, forKey: "attributedTitle")
        controller.setValue(attributedMessage, forKey: "attributedMessage")
        
        
        
        controller.addAction(okAction)
        if MapViewController.MARKERS.count > 0 && TaskAdderViewController.currentMarkerName != "" {
            controller.addAction(showAction)
            ToDoTableViewController.status = true
            ToDoTableViewController.current_key = ToDoTableViewController.DATA[indexPath.row].marker
        }
        
        self.present(controller, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // delListData(element: DATA[indexPath.row] )
            ToDoTableViewController.DATA.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            COUNTER -= 1
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
