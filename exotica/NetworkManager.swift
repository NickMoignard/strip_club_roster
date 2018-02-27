//
//  NetworkManager.swift
//  exotica
//
//  Created by Nick Moignard on 27/2/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    func request() -> Void {
        Alamofire.request("http://52.64.174.22:3000/api/v1/set_times.json").responseJSON {
            response in
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
}
