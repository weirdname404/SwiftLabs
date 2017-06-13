//
//  API.swift
//  travel-planning_iOs
//
//  Created by Александр Сивцов on 12/02/2017.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import Foundation

struct OPoint {
    var lat: Double
    var lon: Double
    
    init() {
        lat = 0
        lon = 0
    }
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

struct OSegment {
    var start: OPoint
    var end: OPoint
    
    init() {
        start = OPoint()
        end = OPoint()
    }
    init(start: OPoint, end: OPoint) {
        self.start = start
        self.end = end
    }
}

class ORoute {
    var segments: [OSegment] = []
    
    init() {}
    
    init(segments: [OSegment]) {
        self.segments = segments
    }
}



class API {
    var url: String = ""
    var base_path = "http://193.41.78.121:3001/api/"
    var routename: String = "best_trip";
    
    func get_route() -> ORoute {
        
        return ORoute(segments: [
            OSegment(start: OPoint(lat: 55.750246, lon: 37.654444), end: OPoint(lat: 53.282623, lon: 36.576040)),
            OSegment(start: OPoint(lat: 53.282623, lon: 36.576040), end: OPoint(lat: 51.672373, lon: 39.206488)),
            OSegment(start: OPoint(lat: 51.672373, lon: 39.206488), end: OPoint(lat: 48.706569, lon: 44.510876)),
            OSegment(start: OPoint(lat: 48.706569, lon: 44.510876), end: OPoint(lat: 47.236982, lon: 38.877552)),
            ])
    }
}
