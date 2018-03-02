//
//  SetTime.swift
//  exotica
//
//  Created by Nick Moignard on 28/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import Foundation

struct SetTime {
    
    var stage_id: Int, dancer_id: Int, time: Date, id: Int
    
    init(id: Int, stage_id: Int = 0, dancer_id: Int = 0, time: Date = Date()) {
        self.id = id
        self.stage_id = stage_id
        self.dancer_id = dancer_id
        self.time = time
    }
}
