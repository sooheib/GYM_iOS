//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import Foundation

var thisDateToday = ""

let date = Date()
let calender = Calendar.current
let day = calender.component(.day, from: date)
let month = calender.component(.month, from: date)
let year1 = calender.component(.year, from: date)
let text = calender.component(.weekday, from: date)

func whatMonth(month: Int) -> String {
    switch month{
    case 1, 13: return "January"
    case 2: return "February"
    case 3: return "March"
    case 4: return "April"
    case 5: return "May"
    case 6: return "June"
    case 7: return "July"
    case 8: return "August"
    case 9: return "September"
    case 10: return "October"
    case 11: return "November"
    case 12, 0: return "December"
    
    default: return ""
    }
}
let theMonth = whatMonth(month: month)

let formatter = DateFormatter()

var fromDate = Date()
var toDate = Date()


// Getting future 7 day dates
func getDates(/*_ from: Date, _ to: Date*/) -> [String]
{
    fromDate = date  //formatter.date(from: "2016 01 05")
    toDate = date.addingTimeInterval((60*60*24) * 6)
    
    var oneDay = DateComponents()
    oneDay.day = 1
    formatter.dateFormat = "yyyyMMdd"
    
    let cal = Calendar.current
    
    var dates = [String]()
    
    var start = fromDate
    while start <= toDate
    {
        //dates.append(start)
        let stringDate = formatter.string(from: start)
        //let appendThis = formatter.date(from: stringDate)
        dates.append(stringDate)
        start = cal.date(byAdding: oneDay, to: start)!
    }
    
    return dates
}

// Getting dates the 7 past day dates
func getBackDates(/*_ from: Date, _ to: Date*/) -> [String]
{
    fromDate = date  //formatter.date(from: "2016 01 05")
    toDate = date.addingTimeInterval((60*60*24) * -6)
    
    var oneDay = DateComponents()
    oneDay.day = 1
    formatter.dateFormat = "yyyyMMdd"
    
    let cal = Calendar.current
    
    var dates = [String]()
    
    var start = toDate
    while start <= fromDate
    {
        //dates.append(start)
        let stringDate = formatter.string(from: start)
        //let appendThis = formatter.date(from: stringDate)
        dates.append(stringDate)
        start = cal.date(byAdding: oneDay, to: start)!
    }
    
    return dates
}


// Getting todays date
func get1Day() -> String {
    formatter.dateFormat = "yyyyMMdd"
    let stringDate = formatter.string(from: fromDate)
    return stringDate
}






