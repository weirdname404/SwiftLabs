//
//  MapViewController.swift
//  travel-planning_iOs
//
//  Created by Александр Сивцов on 13/05/2017.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    static var MARKERS = [String: CLLocationCoordinate2D]()
    static var annotations = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var startPoint : MKPlacemark!
    var endPoint   : MKPlacemark!
    
    var currentRoute: MKRoute?
    let locationManager = CLLocationManager()
    
    static var points_array: [OSegment] = []
    static var points: [CLLocationCoordinate2D] = []
    
    var titleField: UITextField?
    
    override func viewDidAppear(_ animated: Bool) {
        if ToDoTableViewController.status {
            updateRoute()
            var a = 0
            
            for i in MapViewController.points {
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = i
                annotation.title = Array(MapViewController.MARKERS.keys)[a]
                self.mapView.addAnnotation(annotation)
                a += 1
            }
            
            //Zoom to user location
            let markerLocation = MapViewController.MARKERS[ToDoTableViewController.current_key]
            let viewRegion = MKCoordinateRegionMakeWithDistance(markerLocation!, 200, 200)
            mapView.setRegion(viewRegion, animated: false)
            
            ToDoTableViewController.status = false
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        
        if #available(iOS 9.0, *) {
            mapView.showsCompass = true
            mapView.showsScale = true
            mapView.showsTraffic = true
        }
        
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self

        // Request for a user's authorization for location services
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        
        //Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
//        //Zoom to user location
//        let noLocation = CLLocationCoordinate2D()
//        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
//        mapView.setRegion(viewRegion, animated: false)
        
        //getRoute()
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 0.25
        mapView.addGestureRecognizer(longPressRecogniser)
        
        DispatchQueue.main.async {
            
            self.locationManager.startUpdatingLocation()
        }
    }
    
    
    
    func handleLongPress(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let alertController = UIAlertController(title: "Marker name", message: "Enter marker name", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            MapViewController.points.append(touchMapCoordinate)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchMapCoordinate
            
            if let field = self.titleField {
                if (field.text?.isEmpty)! || field.text?[(field.text?.startIndex)!] == " " {
                    annotation.title = "No name"
                }
                    
                else {
                    annotation.title = field.text
                    MapViewController.MARKERS.updateValue(touchMapCoordinate, forKey: field.text!)
                    
                }
            }
            
            self.mapView.addAnnotation(annotation)
            MapViewController.annotations.append(annotation)
            self.updateRoute()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
            
        })
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.addTextField { (textField) -> Void in
            self.titleField = textField
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func updateRoute() {
        print(MapViewController.points)
        if MapViewController.points.count == 0 {
            mapView.removeOverlays(mapView.overlays)
        } else if MapViewController.points.count > 1 {
            for i in 0...(MapViewController.points.count-2) {
                let startPointCoords = MapViewController.points[i]
                let endPointCoords = MapViewController.points[i+1]
                
                self.startPoint = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: startPointCoords.latitude, longitude: startPointCoords.longitude))
                self.endPoint   = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: endPointCoords.latitude, longitude: endPointCoords.longitude))
                
                let directionRequest = MKDirectionsRequest()
                directionRequest.source = MKMapItem(placemark: self.startPoint)
                directionRequest.destination = MKMapItem(placemark: self.endPoint)
                let directions = MKDirections(request: directionRequest)
                directions.calculate { (routeResponse, routeError) -> Void in
                    guard let routeResponse = routeResponse else { if let routeError = routeError {
                        print("Error: \(routeError)")
                        }
                        return
                    }
                    
                    let route = routeResponse.routes[0]
                    self.currentRoute = route
                    //self.mapView.removeOverlays(self.mapView.overlays)
                    self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
                    let rect = route.polyline.boundingMapRect
                    //self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                }
            }
        }
    }
    
    @IBAction func clearRoute(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        MapViewController.points.removeAll()
        updateRoute()
        MapViewController.MARKERS.removeAll()
    }
    
//    func getRoute()-> Void{
//        //var request = URLRequest(url: URL(string: "http://192.168.1.236:1337/getPoints")!)
//        var request = URLRequest(url: URL(string: "http://192.168.43.168:1337/getPoints")!)
//        request.httpMethod = "POST"
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else { // check for fundamental networking error
//                return
//            }
//            
//            let jsonArray = try? JSONSerialization.jsonObject(with: data, options:[])
//            let t = jsonArray as! NSArray
//            
//            for index in t {
//                
//                let res = index as! NSDictionary
//                print(res)
//                print(res["final_point"]!)
//                let st = OPoint(lat: (res["start_point"]! as AnyObject).doubleValue, lon: (res["start_point"]! as AnyObject).doubleValue)
//                let fn = OPoint(lat: (res["final_point"]! as AnyObject).doubleValue, lon: (res["final_point"]! as AnyObject).doubleValue)
//                self.points_array.append(OSegment(start: st, end: fn))
//                
//            }
//            let route = ORoute(segments: self.points_array)
//            
//            var points: [CLLocationCoordinate2D] = []
//            for seg in route.segments {
//                points.append(CLLocationCoordinate2DMake(seg.start.lat, seg.start.lon));
//            }
//            
//            self.startPoint = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: route.segments[0].start.lat, longitude: route.segments[0].start.lon))
//            self.endPoint   = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: route.segments[0].end.lat  , longitude: route.segments[0].end.lon))
//            
//            let directionRequest = MKDirectionsRequest()
//            directionRequest.source = MKMapItem(placemark: self.startPoint)
//            directionRequest.destination = MKMapItem(placemark: self.endPoint)
//            let directions = MKDirections(request: directionRequest)
//            directions.calculate { (routeResponse, routeError) -> Void in
//                guard let routeResponse = routeResponse else { if let routeError = routeError {
//                    print("Error: \(routeError)")
//                    }
//                    return
//                }
//                
//                let route = routeResponse.routes[0]
//                self.currentRoute = route
//                self.mapView.removeOverlays(self.mapView.overlays)
//                self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
//                let rect = route.polyline.boundingMapRect
//                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
//            }
//            
//            
//        }
//        task.resume()
//    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        
        renderer.lineWidth = 3.0
        return renderer
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
