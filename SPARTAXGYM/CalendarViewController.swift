//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import UIKit
import Foundation
import Firebase
import JTAppleCalendar



class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var monthNameLabel: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var previousMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!

    //let data: DataServices = DataServices()
    //let userID = FIRAuth.auth()?.currentUser?.uid
    
    let formatter = DateFormatter()
    
    let testCalendar: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if FIRApp.defaultApp() == nil {
            FIRApp.configure()
        }
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.calendarView.registerCellViewXib(fileName: "CellView")
        
        
        // Do any additional setup after loading the view.
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.firstDayOfWeek = .monday
        calendarView.allowsMultipleSelection = true
        calendarView.scrollEnabled = false

        workoutLabel.text = currentworkout


        monthNameLabel.text = whatMonth(month: calendarView.currentCalendarDateSegment().month)
        
        calendarView.layer.cornerRadius = 40
        calendarView.clipsToBounds = true
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)

        self.navigationController?.isNavigationBarHidden = true
        calendarView.scrollToDate(date)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
    }
    
    @IBAction func nextMonthPressed(_ sender: AnyObject) {
        previousMonthButton.isHidden = false
        nextMonthButton.isHidden = true
        let thisMonth = (calendarView.currentCalendarDateSegment().month) + 1
        print(thisMonth)

        calendarView.scrollToNextSegment()
        monthNameLabel.text = whatMonth(month: thisMonth)
        
        calendarView.reloadData()
       
        
    }
    
    @IBAction func previousMonthPressed(_ sender: AnyObject) {
        let thisMonth = calendarView.currentCalendarDateSegment().month - 1
        calendarView.scrollToPreviousSegment()
        monthNameLabel.text = whatMonth(month:  thisMonth)
        calendarView.reloadData()
        
        previousMonthButton.isHidden = true
        nextMonthButton.isHidden = false
        
    }
    

    
    @IBAction func submitDates() {
        
        for date in calendarView.selectedDates {
            formatter.dateFormat = "yyyyMMdd"
            let dateToRegister = formatter.string(from: date)
            print(dateToRegister)
            data.ref.child("users").child(userID!).child("days").child(dateToRegister).child(currentworkout).setValue(["workoutComplete": "false", "set1Rep": "0", "set1Pounds": "0","set2Rep": "0", "set2Pounds": "0","set3Rep": "0", "set3Pounds": "0"])
            
            
        }
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        
        appendSetupWorkout()
    
    }
    

    
    
    func methodOfReceivedNotification(notification: NSNotification){
        //Take Action on Notification
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        self.performSegue(withIdentifier: "calendarSetupSegue", sender: self)
    }
}



extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> (startDate: Date, endDate: Date, numberOfRows: Int, calendar: Calendar) {
        // You can set your date using Date() or NSDateFormatter. Your choice.

        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let firstDate = Date() //formatter.date(from: "2013 01 05")
        let secondDate = date.addingTimeInterval((60*60*24) * 30)
        let numberOfRows = 6
        let aCalendar = Calendar.autoupdatingCurrent // Properly configure your calendar to your time zone here
        
        return (startDate: firstDate, endDate: secondDate, numberOfRows: numberOfRows, calendar: aCalendar)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        (cell as! CellView2).setupCellBeforeDisplay(cellState: cellState, date: date)
    }
    
    func calendar(_ calendar : JTAppleCalendarView, canSelectDate date : Date, cell: JTAppleDayCellView, cellState: CellState) -> Bool {
        let cell = (cell as! CellView2)
        cell.cellSelectionChanged(cellState: cellState)
        return true
    }

    func calendar(_ calendar : JTAppleCalendarView, canDeselectDate date : Date, cell: JTAppleDayCellView, cellState: CellState) -> Bool {
        let cell = (cell as! CellView2)
        cell.cellSelectionChanged(cellState: cellState)
        return true
    }
 
    
    

    /*
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: Date, endingWithDate endDate: Date) {
        let monthName = theMonth
        let year = year1
        monthNameLabel.text = monthName
        yearLabel.text = "\(year)"
    }
 */


}

