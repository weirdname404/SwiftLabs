//
//  Travel.swift
//  travel-planning_iOs
//
//  Created by Александр Сивцов on 12/02/2017.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import Foundation

class Travel {
    var id:                     Int
    var vc_travel_name:         String
    var d_begin:                Date
    var d_end:                  Date
    var user_id:                Int
    
    init(id:                    Int,
         vc_travel_name:        String,
         d_begin:               Date,
         d_end:                 Date,
         user_id:               Int) {
        
        self.id =               id
        self.vc_travel_name =   vc_travel_name
        self.d_begin =          d_begin
        self.d_end =            d_end
        self.user_id =          user_id
    }
}
