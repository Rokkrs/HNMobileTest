//
//  Hits.swift
//  HNMobileTest
//
//  Created by Oscar Cuadra on 1/27/18.
//  Copyright © 2018 Oscar Cuadra. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Hit: Object {
    
    dynamic var story_id: String?
    dynamic var parent_id: Int?
    
    dynamic var num_comments: Int?
    dynamic var comment_text: String?
    dynamic var story_text: String?
    
    dynamic var points: String?
    dynamic var author: String?
    
    dynamic var url: String?
    dynamic var story_url: String?
    
    dynamic var title: String?
    dynamic var story_title: String?
    
    dynamic var created_at_i: Int?
    dynamic var created_at: String?
    
    
     func customInit(json: JSON) -> List<Hit> {
        let hits = List<Hit>()
        for item in json["hits"].arrayValue {
            let hit = Hit()
            hit.story_id = item["story_id"].stringValue
            hit.parent_id = Int(item["parent_id"].stringValue)
            hit.num_comments = Int(item["num_comments"].stringValue)
            hit.comment_text = item["comment_text"].stringValue
            hit.story_text = item["story_text"].stringValue
            hit.points = item["points"].stringValue
            hit.author = item["author"].stringValue
    
            hit.url = item["url"].stringValue
            hit.story_url = item["story_url"].stringValue
            hit.title = item["title"].stringValue
            hit.story_title = item["story_title"].stringValue
    
            hit.created_at_i = Int(item["created_at_i"].stringValue)
            hit.created_at = item["created_at"].stringValue
            
            hits.append(hit)
        }
        return hits
    }
    
    override static func primaryKey() -> String? {
        return "story_id"
    }
    
    
//    func formatingDate(dateStr: String) -> String {
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssxx"
//        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601)! as Calendar
//        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
//        if let date = formatter.date(from: dateStr) {
//            print(date)   // "2016-05-27 13:33:00 +0000\n" -4hs
//            let dateComponentsFormatter = DateComponentsFormatter()
//            dateComponentsFormatter.allowedUnits = [.day,.hour,.minute,.second]
//            dateComponentsFormatter.unitsStyle = .full
//             print(dateComponentsFormatter.string(from: date, to: NSDate() as Date) ?? "") // 6 days, 17 hours, 51 minutes, 29 seconds
//        return dateComponentsFormatter.string(from: date, to: NSDate() as Date) ?? ""
////            print(dateComponentsFormatter.string(from: date, to: NSDate() as Date) ?? "") // 6 days, 17 hours, 51 minutes, 29 seconds
//        }
//        return ""
//    }
//
//
//
//    func getTimeParsed()dateStr: String {
//
//    let dateRangeStart = Date()
//    let dateRangeEnd = Date().addingTimeInterval(12345678)
//    let components = Calendar.current.dateComponents([.weekOfYear, .month, .day, .minute, .hour, .second], from: dateRangeStart, to: dateRangeEnd)
//
//
//        let calendar = NSCalendar.current
//        let date = Date(timeIntervalSince1970: interval)
//        if calendar.isDateInYesterday(date) { return "Yesterday" }
//        else if calendar.isDateInToday(date) { return "Today" }
//        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
//    }
}

