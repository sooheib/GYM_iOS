//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import Firebase

class StartOverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var todaysWorkoutTV: UITableView!
    
    var y = Workouts()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        todaysWorkoutTV.delegate = self
        todaysWorkoutTV.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        todaysWorkoutTV.reloadData()
        todaysWorkoutTV.rowHeight = 80
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayWorkoutExercises.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workouts") as! StartWorkoutTableViewCell
        
        cell.workoutName.text = todayWorkoutExercises[indexPath.row]
        let thisWorkout = todayWorkoutExercises[indexPath.row]
        
        if todayWorkoutExercisesCompleted[thisWorkout] == "true" {
            cell.completeIcon.alpha = 1
            
            
        } else {
            cell.completeIcon.alpha = 0.3
            
        }
        
        return cell
    }

    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.



        
        if segue.identifier == "chosenWorkoutSegue"{
            let chosenWorkoutVC = segue.destination as? StartChosenWorkoutViewController
            
            
            guard let cell = sender as? UITableViewCell, let indexPath = todaysWorkoutTV.indexPath(for: cell) else {
                return
            }
            let thisWorkout = todayWorkoutExercises[indexPath.row]
            tempWorkout.name = thisWorkout
            tempTodayWorkoutIndexPathRow = todayWorkoutExercises[indexPath.row]
            
            
            if todayWorkoutExercisesCompleted[thisWorkout] == "true"{

                tempFiller()
                chosenWorkoutVC?.isWorkoutComplete = true
                chosenWorkoutVC?.x.name = todayWorkoutExercises[indexPath.row]

                
                
            } else {
                chosenWorkoutVC?.isWorkoutComplete = false
            }
        }
        
        
    }
    

}
