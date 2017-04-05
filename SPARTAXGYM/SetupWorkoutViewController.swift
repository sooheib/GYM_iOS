//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//
import UIKit
import Firebase


class SetupWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var thisWeeksWorkoutTableView: UITableView!
    @IBOutlet weak var fromAndToDate: UILabel!
    let theDate = ""
    
    //let data: DataServices = DataServices()
    //let userID = FIRAuth.auth()?.currentUser?.uid
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        if FIRApp.defaultApp() == nil {
//            FIRApp.configure()
//        }
        
        thisWeeksWorkoutTableView.delegate = self
        thisWeeksWorkoutTableView.dataSource = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("View will appear test")
        NotificationCenter.default.addObserver(self, selector: #selector(self.updated), name: NSNotification.Name(rawValue: "NotificationIdentifier1"), object: nil)
        thisWeeksWorkoutTableView.rowHeight = 80
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NotificationIdentifier1"), object: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red:0.16, green:0.18, blue:0.23, alpha:0.9)
        
        
        let title = UILabel()
    //    title.font = UIFont(name: "OpenSans", size: 20)!
        title.textColor = UIColor.white
        title.textAlignment = NSTextAlignment.center
        
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
        header.textLabel?.textAlignment = .center
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < setupWorkoutSection.count {
            formatter.dateFormat = "yyyyMMdd"
            let thisIsDate = setupWorkoutSection[section]
            let convertToDate = formatter.date(from: thisIsDate)
            formatter.dateFormat = "MM - dd - yyyy"
            let stringDate = formatter.string(from: convertToDate!)
            //print("sectionTitleCall")
            return  stringDate
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //print("numSectionsCall")
        var numSecs = setupWorkoutSection.count
        return numSecs
        //return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numRowsInSection")
        var numRows = setupWorkoutDays[section].count
        return numRows
        //return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workouts") as! SetupWorkoutTableViewCell
        
        cell.theWorkout.text = setupWorkoutDays[indexPath.section][indexPath.row]
        
        
        formatter.dateFormat = "yyyyMMdd"
        let thisIsDate = setupWorkoutSection[indexPath.section]
        let convertToDate = formatter.date(from: thisIsDate)
        formatter.dateFormat = "MM - dd - yyyy"
        let stringDate = formatter.string(from: convertToDate!)
        //let newDate = formatter.string(from: stringDate!)
        //cell.workoutDate.text = stringDate
        
        print(setupWorkoutSection[indexPath.section])
        
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func updated() {
        thisWeeksWorkoutTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            data.ref.child("users").child(userID!).child("days").child(setupWorkoutSection[indexPath.section]).child(setupWorkoutDays[indexPath.section][indexPath.row]).removeValue()
            appendSetupWorkout()
            
        }
        
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


