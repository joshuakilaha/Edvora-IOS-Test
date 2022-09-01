//
//  DateConverter.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import Foundation

class DateConverter {
    // MARK: DateConverter
    /// Converts Date from milisecond and returns as String i.e 31 Aug, 8:00 am
    func dateOrdered(_ date: String) -> String {
        let timeStamp = Date(timeIntervalSince1970: TimeInterval(date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, h:mm a"
        return dateFormatter.string(from: timeStamp)
    }
}
