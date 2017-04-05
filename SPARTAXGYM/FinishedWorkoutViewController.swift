//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//
import UIKit
import Firebase

class FinishedWorkoutViewController: UIViewController {
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var set1Rep: UILabel!
    @IBOutlet weak var set1Pounds: UILabel!
    
    @IBOutlet weak var set2Rep: UILabel!
    @IBOutlet weak var set2Pounds: UILabel!
    
    @IBOutlet weak var set3Rep: UILabel!
    @IBOutlet weak var set3Pounds: UILabel!
    
    var x: Workouts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        if x != nil {
         //   backButton.isHidden = false
            workoutName.text = x?.name
        
            set1Rep.text = x?.set1rep
            set1Pounds.text = x?.set1pounds
        
            set2Rep.text = x?.set2rep
            set2Pounds.text = x?.set2pounds
        
            set3Rep.text = x?.set3rep
            set3Pounds.text = x?.set3pounds
        } else {
           // backButton.isHidden = true
            workoutName.text = tempWorkout.name
            set1Rep.text = tempWorkout.set1rep
            set2Rep.text = tempWorkout.set2rep
            set3Rep.text = tempWorkout.set3rep
            set1Pounds.text = tempWorkout.set1pounds
            set2Pounds.text = tempWorkout.set2pounds
            set3Pounds.text = tempWorkout.set3pounds
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.startTodaysWorkoutsNotif), name: NSNotification.Name(rawValue: "TodaysWorkoutsPosted"), object: nil)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "TodaysWorkoutsPosted"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func completePressed(_ sender: AnyObject) {
        let newToday = get1Day()
        guard let workout = x?.name, let set1rep = x?.set1rep, let set1pounds = x?.set1pounds, let set2rep = x?.set2rep, let set2pounds = x?.set2pounds, let set3rep = x?.set3rep, let set3pounds = x?.set3pounds else {
            startTodaysWorkoutsNotif()
            return
        }
        
        if newToday == thisDateToday {
            data.ref.child("users").child(userID!).child("days").child(thisDateToday).child(workout).setValue(["workoutComplete": "true", "set1Rep": set1rep, "set1Pounds": set1pounds,"set2Rep": set2rep, "set2Pounds": set2pounds,"set3Rep": set3rep, "set3Pounds": set3pounds])
            startTodaysWorkouts()
        }
    }
    
    func startTodaysWorkoutsNotif() {
        
        self.performSegue(withIdentifier: "completeExercise", sender: self)
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
