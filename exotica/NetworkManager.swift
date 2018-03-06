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
    let contentType = ["Content-Type": "application/json"],
        accept = ["Accept":"application/json"]
    let timeModel = TimeModel()
    // TODO: addItem
//    func addItem(db: Table, params: Parameters, completion: @escaping (JSON) -> Void) {
//        let url = createURL(db: db)
//        Alamofire.request(url, method: .put, parameters: params).response {
//            response in
//            // Error handling
//            if let json = self.returnJSON(response: response) {
//                completion(json)
//            }
//        }
//    }
    // TODO: editItem
//    func editItem(db: Table, id: Int, params: Parameters, completion: @escaping (JSON) -> Void) {
//        let url = createItemUrl(db: db, id: id)
//        Alamofire.request(url, method: .patch, parameters: params).response {
//            response in
//            // Error handling
//            if let json = self.returnJSON(response: response) {
//                completion(json)
//            }
//        }
//    }
    // TODO: deleteItem
//    func deleteItem(db: Table, id: Int, completion: @escaping (JSON) -> Void) {
//        let url = createItemUrl(db: db, id: id)
//        Alamofire.request(url, method: .delete, parameters: contentType).response {
//            response in
//            // ERROR HANDLING GOES HERE
//            if let json = self.returnJSON(response: response) {
//                completion(json)
//            }
//        }
//    }
//
    func getItems(db: Table, completion: @escaping (JSON) -> Void) {
        let url = createURL(db: db)
        print("making a GET request: \(url)")
        Alamofire.request(url, method: .get, parameters: accept).responseJSON {
            response in
            // error handling
            // print("got a response: \(response)")
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    completion(json)
                } catch {
                    print("error creating JSON object")
                }
            }
        }
    }
    
    // MARK: Helpers
    private func returnJSON(response: DataResponse<Any>) -> JSON? {
        
        if let data = response.data {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments )  {
//                print("create JSON object with: \(json)")
                return json as? JSON
            } else {
                print("the JSON object was not created")
            }
        } else {
            print("response.data contained nothing")
        }
        return nil
    }
    
    private func createItemUrl(db: Table, id: Int) -> String {
        var url = createURL(db: db)
        url += "/\(id)"
        return url
    }
    
    private func createURL(db: Table = Table.setTimes, json: Bool = true) -> String {
        var baseUrl = "http://52.64.174.22:3000/api/v1"
        switch db {
            case .dancers:
                baseUrl += "/dancers"
            case .stages:
                baseUrl += "/stages"
            case .setTimes:
                baseUrl += "/set_times"
        }
        baseUrl += json ? ".json" : ""
        return baseUrl
    }
    
    
    public func parseJSONIntoObjects(type: Table, json: JSON) -> [Any] {
        switch type {
            case .dancers:
                
                var dancers = [Dancer]()  // to store our created dancers
                guard let items = json.array else {
                    print("failure: could not create Dancer array")
                    return [Any]()
                }
                
                // iterate over the array of objects
                for item in items {
                    var account: Float = 0.0, id: Int = 0, fakeName = "", fullName = ""
                    // check for null before force unwrapping data
                    if (item["account"].float != nil) { account += item["account"].float! }
                    if (item["id"].int != nil) { id += item["id"].int! }
                    if (item["full_name"].string != nil) { fullName += item["full_name"].string! }
                    if (item["fake_name"].string != nil) { fakeName += item["fake_name"].string! }
                    
                    // create and add dancer to our return variable
                    let dancer = Dancer(id: id, fakeName: fakeName, fullName: fullName, account: account)
                    dancers.append(dancer)
                }
                return dancers
            
            case .stages:
                var stages = [Stage]()
                guard let items = json.array else {
                    print("failure: could not create Stages array")
                    return [Any]()
                }
                for item in items {
                    var id: Int = 0, name = ""
                    
                    if (item["id"].int != nil) { id = item["id"].int! }
                    if ( item["name"].string != nil ) { name = item["name"].string! }
                    
                    let stage = Stage(id: id, name: name)
                    stages.append(stage)
                    
                }
                return stages
            
            case .setTimes:
                var setTimes = [SetTime]()
                guard let jsonArray = json.array else {
                    print("failure: could not create SetTimes array")
                    return [Any]()
                }

                for item in jsonArray  {
//                    print("\(item)")
                    var id:Int = 0, stageId:Int = 0, dancerId: Int = 0, timeString = ""
                    if ( item["id"].int != nil ) { id += item["id"].int! }
                    if ( item["stage_id"].int != nil ) { stageId += item["stage_id"].int! }
                    if ( item["dancer_id"].int != nil ) { dancerId += item["dancer_id"].int! }
                    if ( item["time"].string != nil ) { timeString += item["time"].string! }
                    
                    if let _timeDate = timeModel.stringToDateForSetTimeStruct(time: timeString) {
                        let setTime = SetTime(id: id, stage_id: stageId, dancer_id: dancerId, time: _timeDate)
                        setTimes.append(setTime)
                        
                    }
                    
                } 
                return setTimes
        }
    }
    
}


enum Table {
    case dancers
    case stages
    case setTimes
}
