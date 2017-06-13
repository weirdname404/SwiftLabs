//
//  Point.swift
//  travel-planning_iOs
//
//  Created by Александр Сивцов on 12/02/2017.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import Foundation

class Point {
    var id:                 Int
    var name:               String
    var vc_title:           String
    var lon:                Double
    var lat:                Double
    var d_begin:            Date
    var d_end:              Date
    var travel_id:          Int
    var n_serial:           Int
    var b_start:            Date
    var b_end:              Date
    
    
    
    
    
    init(id:                 Int,
         name:               String,
         vc_title:           String,
         lon:                Double,
         lat:                Double,
         d_begin:            Date,
         d_end:              Date,
         travel_id:          Int,
         n_serial:           Int,
         b_start:            Date,
         b_end:              Date) {
        
         self.id =           id
         self.name =         name
         self.vc_title =     vc_title
         self.lon =          lon
         self.lat =          lat
         self.d_begin =      d_begin
         self.d_end =        d_end
         self.travel_id =    travel_id
         self.n_serial =     n_serial
         self.b_start =      b_start
         self.b_end =        b_end
    }
}
