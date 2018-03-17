//
//  ExtendString.swift
//  exotica
//
//  Created by Nick Moignard on 16/3/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import Foundation

extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
