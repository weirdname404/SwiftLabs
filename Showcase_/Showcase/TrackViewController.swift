//
//  TrackViewController.swift
//  Showcase
//
//  Created by Студент on 2/1/17.
//  Copyright © 2017 HSE. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TrackViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    @IBOutlet weak var locationText: UITextView!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func changeToggle(_ sender: Any) {
        if toggleSwitch.isOn {
            
            // if the device’s location services are disabled
            if (CLLocationManager.locationServicesEnabled() == false) {
                self.toggleSwitch.isOn = false
            }
            if locationManager == nil {
                
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.distanceFilter = 10.0
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            
        } else {
            
            if locationManager != nil {
                locationManager.stopUpdatingLocation()
            }
            mapView.showsUserLocation = false
            mapView.userTrackingMode = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     
    // takes the last reported location information and outputs its description value to the text view.
    // (Protocol Method)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
        [CLLocation]) {
        
        let location: CLLocation = locations[locations.endIndex-1]
        self.locationText.text = location.description
        
    }
    
    // the didFailWithError function that is called if 
    // there is a fault while trying to obtain a location 
    // and that writes the error description to the text view.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationText.text = "failed with error \(error.localizedDescription) "
    }


}

