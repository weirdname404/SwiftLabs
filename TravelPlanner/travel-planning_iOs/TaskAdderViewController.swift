//
//  TaskAdderViewController.swift
//  travel-planning_iOs
//
//  Created by Студент on 5/22/17.
//  Copyright © 2017 Александр Лебедев. All rights reserved.
//

import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}

struct Task_Data {
    var task_name = ""
    var task_description = ""
    var task_date = ""
    var task_deadline = ""
    var user_name = ""
    var marker = ""
}


class TaskAdderViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let hint1 = "Write here task name..."
    let hint2 = "Write here task description..."
    let mapVC = MapViewController()
    let api = API()
    let tableVC = ToDoTableViewController()
    var chosenMarker = ""
    var markerPicker: UIPickerView!
    
    static var MARKER_NAMES: [String] = [String]()
    static var currentMarkerName = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.descriptionField.delegate = self
        self.markerTF.delegate = self
        datePicker.isHidden = true
        self.markerTF.isHidden = true
        mapMarkerLabel.text = "Set Marker on map and give a TaskName"
        showHint1()
        showHint2()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var mapmarkerLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var markerTF: UITextField!
    @IBOutlet weak var mapMarkerLabel: UILabel!
    
    @IBAction func `switch`(_ sender: Any) {
        if switchButton.isOn {
            datePicker.isHidden = false
        }
            
        else if !switchButton.isOn {
            datePicker.isHidden = true
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBAction func addTask(_ sender: UIButton) {
        
        if self.textField.text != hint1 {
//            DATA.append(String(COUNTER + 1) + ") " + self.textField.text!)
            ToDoTableViewController.DATA.append(taskToStruct())
            tableVC.tableView.reloadSectionIndexTitles()
        }
        // addListData(trip_name: api.routename, elem: self.textField.text!)
        // DATA = []
        navigationController!.popViewController(animated: true)
    }
    
    func taskToStruct() -> Task_Data {
        
        var deadlineInfo = String()
        
        if switchButton.isOn
        {
            deadlineInfo = datePicker.date.toString()
        }
            
        else
        {
            deadlineInfo = "not set."
        }

        return Task_Data(task_name: self.textField.text!, task_description: self.descriptionField.text!, task_date: Date().toString(), task_deadline: deadlineInfo, user_name: ViewController.currentUser, marker: chosenMarker)
    }
    
    //    func addListData(trip_name: String, elem: String)-> Void{
    //        //var request = URLRequest(url: URL(string: "http://192.168.1.236:1337/addListData?trip_name=" + trip_name + "&&elem=" + elem)!)
    //        let query = URL(string: "http://192.168.43.168:1337/addListData?trip_name=" + trip_name + "&&elem=" + elem.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!
    //        var request = URLRequest(url: query)
    //        request.httpMethod = "POST"
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            guard let _ = data, error == nil else {                                                                 return
    //            }
    //        }
    //        task.resume()
    //    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        if (self.textField.text?.isEmpty)! || self.textField.text?[(self.textField.text?.startIndex)!] == " " {
            showHint1()
        }
            
        else if self.descriptionField.text.isEmpty || self.descriptionField.text?[(self.descriptionField.text?.startIndex)!] == " " {
            showHint2()
        }
        
        else if MapViewController.MARKERS.count > 0 && self.textField.text != hint1 {
            self.markerTF.isHidden = false
            mapMarkerLabel.text = "Map Marker"
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if self.textField.text == hint1 {
            self.textField.text = nil
            self.textField.textColor = UIColor.black
        }
        
        else if self.markerTF.isEditing {
            self.datePicker.isHidden = true
            self.pickUpValue(markerTextField: self.markerTF)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if self.descriptionField.text == hint2 {
            self.descriptionField.text = nil
            self.descriptionField.textColor = UIColor.black
            
        }
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        
        if (self.textField.text?.isEmpty)! || self.textField.text?[(self.textField.text?.startIndex)!] == " " {
            showHint1()
        }
        
        else if MapViewController.MARKERS.count > 0 && self.textField.text != hint1 {
            self.markerTF.isHidden = false
            mapMarkerLabel.text = "Map Marker"
            
        }
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {

        textView.resignFirstResponder()
        
        if self.descriptionField.text.isEmpty || self.descriptionField.text?[(self.descriptionField.text?.startIndex)!] == " " {
            showHint2()
        }
        return true
    }
    // Show Hints instead of placeholders
    func showHint1() {
        self.textField.text = hint1
        self.textField.textColor = UIColor.lightGray
    }
    
    func showHint2() {
        self.descriptionField.text = hint2
        self.descriptionField.textColor = UIColor.lightGray
    }
    
    // Setting Up Adaptive Pickers
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // return number of elements in picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MapViewController.MARKERS.count
    }
    
    // return "content" for picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        TaskAdderViewController.MARKER_NAMES = Array(MapViewController.MARKERS.keys)
        return TaskAdderViewController.MARKER_NAMES[row]
    }
    
    // get currect value for picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenMarker = TaskAdderViewController.MARKER_NAMES[row]
    }
    
    func pickUpValue(markerTextField: UITextField) {
        
        // create frame and size of picker view
        markerPicker = UIPickerView(frame:CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 216)))
        
        // deletates
        markerPicker.delegate = self
        markerPicker.dataSource = self
        
        markerPicker.backgroundColor = UIColor.white
        markerTextField.inputView = self.markerPicker
        
        // toolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.white
        toolBar.sizeToFit()
        
        // buttons for toolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        markerTextField.inputAccessoryView = toolBar
        
    }
    
    // done
    func doneClick() {
        markerTF.resignFirstResponder()
        markerTF.text = chosenMarker
        TaskAdderViewController.currentMarkerName = chosenMarker
        if switchButton.isOn {
            datePicker.isHidden = false
        }
    }
    
    // cancel
    func cancelClick() {
        markerTF.resignFirstResponder()
        if switchButton.isOn {
            datePicker.isHidden = false
        }
    }
}
