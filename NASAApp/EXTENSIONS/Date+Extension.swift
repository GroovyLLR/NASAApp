//
//  Date+Extension.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation


extension Date {
    
    static func dateWith(WithDateFormat dateFormat :String , DateString dateString :String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat =  dateFormat
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    func stringWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter.string(from: self)
    }
}
