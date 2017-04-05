//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class HistoryOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var historyOverviewTableView: UITableView!

    @IBOutlet weak var activityIcon: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        historyOverviewTableView.delegate = self
        historyOverviewTableView.dataSource = self
        // Do any additional setup after loading the view.
        activityIcon.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.historyDayNotif), name: NSNotification.Name(rawValue: "tempHistoryFilled"), object: nil)
        historyOverviewTableView.rowHeight = 80
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tempHistoryFilled"), object: nil)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyOverviewTableView.dequeueReusableCell(withIdentifier: "workoutHistory") as! HistoryTableViewCell
        
        
        formatter.dateFormat = "yyyyMMdd"
        let thisIsDate = historyDays[indexPath.row]
        let convertToDate = formatter.date(from: thisIsDate)
        formatter.dateFormat = "MM/dd/yyyy"
        let stringDate = formatter.string(from: convertToDate!)
        //let newDate = formatter.string(from: stringDate!)
        cell.theDate.text = stringDate
        
        //cell.theDate.text = historyDays[indexPath.row]
        cell.numberOfExercise.text = "\(historyWorkouts[indexPath.row][0])/\(historyWorkouts[indexPath.row][1])"
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIcon.startAnimating()
        activityIcon.isHidden = false
        historyOverviewTableView.isUserInteractionEnabled = false
        
        let currentCell = tableView.cellForRow(at: indexPath) as! HistoryTableViewCell
        let theHistoryDate = currentCell.theDate.text
        formatter.dateFormat = "MM/dd/yyyy"
        let convertedDate = formatter.date(from: theHistoryDate!)
        formatter.dateFormat = "yyyyMMdd"
        let newStringDate = formatter.string(from: convertedDate!)
        tempHistoryDay = newStringDate
        choseHistoryWorkoutDay()
    }
    
    func historyDayNotif() {
        activityIcon.isHidden = true
        activityIcon.stopAnimating()
        historyOverviewTableView.isUserInteractionEnabled = true
        performSegue(withIdentifier: "dateSelectedSegue", sender: self)
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
 

}
