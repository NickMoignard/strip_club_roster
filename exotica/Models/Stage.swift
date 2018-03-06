//
//  Stage.swift
//  exotica
//
//  Created by Nick Moignard on 28/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import Foundation

struct Stage {
    
    var name: String, id: Int
    
    init(id: Int, name: String = "") {
        self.id = id
        self.name = name
    }
}
