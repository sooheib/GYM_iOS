//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class HistoryDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var theDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        tableView.allowsSelection = false
        

        formatter.dateFormat = "yyyyMMdd"
        let thisIsDate = tempHistoryDay
        let convertToDate = formatter.date(from: thisIsDate)
        formatter.dateFormat = "MM/dd/yyyy"
        let stringDate = formatter.string(from: convertToDate!)
        //let newDate = formatter.string(from: stringDate!)
        theDate.text = stringDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = 270
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayHistoryWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutHistory") as! HistoryDayTableViewCell
        if dayHistoryWorkouts[indexPath.row].workoutComplete == "true"{
            cell.workoutName.text = dayHistoryWorkouts[indexPath.row].name
            cell.set1Pounds.text = dayHistoryWorkouts[indexPath.row].set1pounds
            cell.set2Pounds.text = dayHistoryWorkouts[indexPath.row].set2pounds
            cell.set3Pounds.text = dayHistoryWorkouts[indexPath.row].set3pounds
            cell.set1Rep.text = dayHistoryWorkouts[indexPath.row].set1rep
            cell.set2Rep.text = dayHistoryWorkouts[indexPath.row].set2rep
            cell.set3Rep.text = dayHistoryWorkouts[indexPath.row].set3rep
            
        } else if dayHistoryWorkouts[indexPath.row].workoutComplete == "false" {
            cell.workoutName.text = dayHistoryWorkouts[indexPath.row].name
            cell.didntFinishView.isHidden = false
            cell.didNotFinishLabel.isHidden = false
            
        }
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
