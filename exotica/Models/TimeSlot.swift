//
//  TimeSlot.swift
//  exotica
//
//  Created by Nick Moignard on 14/3/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TimeSlot {
    // TODO: write code that initializes the poles dict
    let _poleNameStringArray = ["upstairs_main", "upstairs_secondary", "downstairs_one", "downstairs_two", "downstairs_booth", "downstairs_bar"]
    var poles = [
        "upstairs_main": JSON(),
        "upstairs_secondary": JSON(),
        "downstairs_one" : JSON(),
        "downstairs_two" : JSON(),
        "downstairs_booth" : JSON(),
        "downstairs_bar" : JSON()
    ]
    var time: Date, id: Int
    
    
    
    
    init() {
        self.time = Date()
        self.id = Int()
    }
    
    
    init(time: Date, id: Int, poles: [Any]) {

        
        self.time = time
        self.id = id
        
        var i = 0
        for pole in poles {
            
            var poleJSON = pole as! JSON
            self.poles[_poleNameStringArray[i]] = poleJSON["name"] != nil ? poleJSON["name"] : JSON()
            
            
            i += 1
        }
    }
}
