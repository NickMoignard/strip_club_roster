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
        
        self.poles["upstairs_main"] = JSON(poles[0])
        self.poles["upstairs_secondary"] = JSON(poles[1])
        self.poles["downstairs_one"] = JSON(poles[2])
        self.poles["downstairs_two"] = JSON(poles[3])
        self.poles["downstairs_booth"] = JSON(poles[4])
        self.poles["downstairs_bar"] = JSON(poles[5])
        
    }
}
