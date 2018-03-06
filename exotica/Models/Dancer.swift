//
//  Dancer.swift
//  exotica
//
//  Created by Nick Moignard on 28/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import Foundation

struct Dancer {
    
    
    init(id: Int, fakeName: String = "", fullName: String = "", account: Float = 0.0) {
        self.id = id
        self.fakeName = fakeName
        self.fullName = fullName
        self.account = account
    }
    
    var fakeName: String, fullName: String, account: Float, id: Int
    
    
    
    
}
