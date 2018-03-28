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

    
    public func getItems(db: Table, completion: @escaping (JSON) -> Void) {
        let url = createURL(db: db)
        print("making a GET request: \(url)")
        Alamofire.request(url, method: .get, parameters: accept).responseJSON {
            response in
            // error handling
//            print("got a response: \(response)")
            if let data = response.data {

                do {
                    let json = try JSON(data: data)
                    print(json)
                    completion(json)
                } catch {
                    print("error creating JSON object")
                }
            }
        }
    }
    
    // MARK: Helpers
    private func createURL(db: Table = Table.TimeSlots, json: Bool = true) -> String {
        var baseUrl = "http://13.211.150.198:3000/api"
        switch db {
            case .Dancers:
                baseUrl += "/dancers"
            case .TimeSlots:
                baseUrl += "/time_slots"
        }
        baseUrl += json ? ".json" : ""
        return baseUrl
    }
    private func createItemUrl(db: Table, id: Int) -> String {
        var url = createURL(db: db, json: false)
        url += "/\(id).json"
        return url
    }
    
    public func parseJSONIntoObjects(type: Table, json: JSON) -> [Any] {



        switch type {

            // Parse Dancers
            case .Dancers:
                var dancers = [Dancer]()
                guard let items = json.array else {
                    print("failure: could not create Dancer array")
                    return [Any]()
                }

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



            // Parse Time Slots
            case .TimeSlots:

                var timeSlots = [TimeSlot]()
                
                
                guard let jsonArray = json.array else {
                    print("failure: could not create SetTimes array")
                    return [Any]()
                }




                for item in jsonArray  {
                    var id:Int = 0, timeString = "", poles = [Any]()
                    if ( item["id"].int != nil ) { id += item["id"].int! }
                    if ( item["time"].string != nil ) { timeString += item["time"].string! }
                    if (item["dancers"].array != nil ) { poles = item["dancers"].array! }
                    // TODO: Initialize Poles - Dancer Dict
                    
                    
                    if let _timeDate = timeModel.stringToDateForSetTimeStruct(time: timeString) {
//                        print(_timeDate)
                        let timeSlot = TimeSlot(time: _timeDate, id: id, poles: poles)
                        timeSlots.append(timeSlot)

                    }
                }
                print(timeSlots)
                return timeSlots
        }
    }
    // TODO: addItem
        func addItem(db: Table, params: Parameters, completion: @escaping (JSON) -> Void) {
            let url = createURL(db: db)
            Alamofire.request(url, method: .put, parameters: params).response {
                response in
                // Error handling
                if let data = response.data {
                    
                    do {
                        let json = try JSON(data: data)
                        print(json)
                        completion(json)
                    } catch {
                        print("error creating JSON object")
                    }
                }
            }
        }
    // TODO: editItem
        func editItem(db: Table, id: Int, params: Parameters, completion: @escaping (JSON) -> Void) {
            let url = createItemUrl(db: db, id: id)
            print(params)
            Alamofire.request(url, method: .patch, parameters: params).response {
                response in
                // Error handling
                if let data = response.data {
                    print(data)
                    do {
                        let json = try JSON(data: data)
                        print(json)
                        completion(json)
                    } catch {
                        print("error creating JSON object")
                    }
                }
            }
        }
    // TODO: deleteItem
        func deleteItem(db: Table, id: Int, completion: @escaping (JSON) -> Void) {
            let url = createItemUrl(db: db, id: id)
            Alamofire.request(url, method: .delete, parameters: contentType).response {
                response in
                // ERROR HANDLING GOES HERE
                if let data = response.data {
                    
                    do {
                        let json = try JSON(data: data)
                        print(json)
                        completion(json)
                    } catch {
                        print("error creating JSON object")
                    }
                }
            }
        }
    
    
    //    private func returnJSON(response: DataResponse<Any>) -> JSON? {
    //        if let data = response.data {
    //            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments )  {
    //                return json as? JSON
    //            } else {
    //                print("the JSON object was not created")
    //            }
    //        } else {
    //            print("response.data contained nothing")
    //        }
    //        return nil
    //    }
    
    
    
}


enum Table {
    case Dancers
    case TimeSlots
}
