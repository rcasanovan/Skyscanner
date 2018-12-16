//
//  Date.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

extension Date {
    
    public enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    public static func today() -> Date {
        return Date()
    }
    
    public func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Next,
                   weekday,
                   considerToday: considerToday)
    }
    
    public func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    public func getStringyyyyMMddFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    public func getStringMMMddEEEFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd., EEE"
        return dateFormatter.string(from: self)
    }
    
    public func getStringHHmmFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    public static func getISODateWithString(_ stringDate: String) -> Date? {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        return isoFormatter.date(from: stringDate)
    }
    
    public static func minutesToHoursMinutes(minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
        
}

// MARK: Helper methods
extension Date {
    
    private func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    private func get(_ direction: SearchDirection,
                     _ weekDay: Weekday,
                     considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex
        
        
        guard let date = calendar.nextDate(after: self,
                                           matching: nextDateComponent,
                                           matchingPolicy: .nextTime,
                                           direction: direction.calendarSearchDirection) else {
                                            return Date.today()
        }
        
        return date
    }
    
    private enum SearchDirection {
        case Next
        case Previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .Next:
                return .forward
            case .Previous:
                return .backward
            }
        }
    }
    
}
