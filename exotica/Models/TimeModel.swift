//
//  TimeModel.swift
//  exotica
//
//  Created by Nick Moignard on 2/3/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import Foundation

class TimeModel {
    
    var dateFormatter: DateFormatter
    var prefixNum = "yyyy-MM-ddT".count
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    public func stringToDateForSetTimeStruct(time: String) -> Date? {
        var _time = time
        _time.removeLast(10)
//        if (_time != "") {
//            _time.removeLast(5)
//            print(_time)
//            return dateFormatter.date(from: _time)!
//        }
        print(_time)
        return dateFormatter.date(from: _time)
    }
    

    public func dateToDescription (date: Date) -> String {
        var _dateFormatter = DateFormatter()
        _dateFormatter.dateFormat = "EEEE - dd MMM"
        return _dateFormatter.string(from: date)
    }
    
    
    public func stringToDate (time: String) -> Date {
        var _time = time
        _time.removeLast(5)
        return dateFormatter.date(from: _time)!
    }
    
    public func dateToString (_ time: Date) -> String {
        var _time = dateFormatter.string(from: time)
        _time.removeFirst(prefixNum)
        _time.removeLast(3)
        return _time
    }
    
}
