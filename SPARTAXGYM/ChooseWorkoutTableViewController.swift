//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class ChooseWorkoutTableViewController: UITableViewController {

    var currentBodyChoice = "test"
    var theWorkoutCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  configureView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        print(currentBodyChoice)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        let navBarFont = UIFont(name: "OpenSans", size: 20.0)
        let navBarAttributesDictionary: [String: AnyObject]? = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: navBarFont!]
        
        navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        let customFont = UIFont(name: "OpenSans", size: 17.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], for: UIControlState.normal)
        tableView.rowHeight = 100
        navigationController?.navigationBar.barTintColor = UIColor(red:0.16, green:0.18, blue:0.23, alpha:1.0)
        tableView.rowHeight = 80
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var lowercasedBody = currentBodyChoice.lowercased()
        
        if lowercasedBody == "biceps" {
            theWorkoutCount = bicepWorkouts.count
        } else if lowercasedBody == "chests" {
            theWorkoutCount = chestWorkouts.count
        } else if lowercasedBody == "shoulders" {
            theWorkoutCount = shoulderWorkouts.count
        } else if lowercasedBody == "triceps" {
            theWorkoutCount = tricepWorkouts.count
        } else if lowercasedBody == "calves" {
            theWorkoutCount = calfWorkouts.count
        } else if lowercasedBody == "forearms" {
            theWorkoutCount = forearmWorkouts.count
        } else if lowercasedBody == "glutes" {
            theWorkoutCount = gluteWorkouts.count
        } else if lowercasedBody == "hamstrings" {
            theWorkoutCount = hamstringWorkouts.count
        } else if lowercasedBody == "lats" {
            theWorkoutCount = latWorkouts.count
        } else if lowercasedBody == "lowerback" {
            theWorkoutCount = lowerBackWorkouts.count
        } else if lowercasedBody == "middleback" {
            theWorkoutCount = middleBackWorkouts.count
        } else if lowercasedBody == "quads" {
            theWorkoutCount = quadWorkouts.count
        } else if lowercasedBody == "traps" {
            theWorkoutCount = trapWorkouts.count
        }
        
        
        return theWorkoutCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theWorkout") as! WorkoutTableViewCell
        let lowercasedBody = currentBodyChoice.lowercased()
        
        if lowercasedBody == "biceps" {
            cell.workoutName.text = bicepWorkouts[indexPath.row]
        } else if lowercasedBody == "chests" {
            cell.workoutName.text = chestWorkouts[indexPath.row]
        } else if lowercasedBody == "shoulders" {
            cell.workoutName.text = shoulderWorkouts[indexPath.row]
        } else if lowercasedBody == "triceps" {
            cell.workoutName.text = tricepWorkouts[indexPath.row]
        } else if lowercasedBody == "calves" {
            cell.workoutName.text = calfWorkouts[indexPath.row]
        } else if lowercasedBody == "forearms" {
            cell.workoutName.text = forearmWorkouts[indexPath.row]
        } else if lowercasedBody == "glutes" {
            cell.workoutName.text = gluteWorkouts[indexPath.row]
        } else if lowercasedBody == "hamstrings" {
            cell.workoutName.text = hamstringWorkouts[indexPath.row]
        } else if lowercasedBody == "lats" {
            cell.workoutName.text = latWorkouts[indexPath.row]
        } else if lowercasedBody == "lowerback" {
            cell.workoutName.text = lowerBackWorkouts[indexPath.row]
        } else if lowercasedBody == "middleback" {
            cell.workoutName.text = middleBackWorkouts[indexPath.row]
        } else if lowercasedBody == "quads" {
            cell.workoutName.text = quadWorkouts[indexPath.row]
        } else if lowercasedBody == "traps" {
            cell.workoutName.text = trapWorkouts[indexPath.row]
        }
        

        // Configure the cell...
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! WorkoutTableViewCell
        let theWorkout = currentCell.workoutName.text
        
        currentworkout = theWorkout!
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "chosenWorkout" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if (self.tableView.cellForRow(at: indexPath) as? WorkoutTableViewCell) != nil {
                    let cell = tableView.cellForRow(at: indexPath)
                    let theWorkout = cell?.textLabel?.text
                    currentworkout = theWorkout!
                }
            }
        }
    }
    */

}
