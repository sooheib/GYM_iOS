//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class StartChosenWorkoutViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var theWorkoutName: UILabel!
    var theWorkoutNameInput = ""
    var setsCompleted = 0
    var isWorkoutComplete = false

    @IBOutlet weak var set1Reps: UITextField!
    @IBOutlet weak var set1Pounds: UITextField!

    @IBOutlet weak var set2Reps: UITextField!
    @IBOutlet weak var set2Pounds: UITextField!
    
    @IBOutlet weak var set3Reps: UITextField!
    @IBOutlet weak var set3Pounds: UITextField!
    
    @IBOutlet weak var set1View: UIView!
    @IBOutlet weak var set2View: UIView!
    @IBOutlet weak var set3View: UIView!
    @IBOutlet weak var completedView: UIView!
    
    @IBOutlet weak var set2DoneButton: UIButton!
    @IBOutlet weak var set3DoneButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var currentSetLabel: UILabel!
    var x = Workouts()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        theWorkoutName.text = tempWorkout.name
        resetViews()
        
        //WORKONTHIS SECTION PHILLIP!!!!!
    //    hideKeyboardWhenTappedAround()
        set1Pounds.delegate = self
        set1Reps.delegate = self
        set2Pounds.delegate = self
        set2Reps.delegate = self
        set3Pounds.delegate = self
        set3Reps.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToSegue), name: NSNotification.Name(rawValue: "tempFilled"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tempFilled"), object: nil)
    }
    
    func resetViews() {
        set1View.isHidden = false
        set2View.isHidden = true
        set3View.isHidden = true
        completedView.isHidden = true
        
        currentSetLabel.text = "Currently Set 1 of 3"
        completeButton.isEnabled = false

        
    }
    
    @IBAction func set1DonePressed(_ sender: AnyObject) {
        guard let reps = set1Reps.text, let pounds = set1Pounds.text else {
            return
        }
        guard let intReps = Int(reps), let intPounds = Int(pounds) else {
            return
        }
        if intReps >= 0 && intPounds >= 0 {
            
            //Change to an overlay or something
            set1View.isHidden = true
            set2View.isHidden = false
            currentSetLabel.text = "Currently Set 2 of 3"
        }
        
    }
    
    @IBAction func set2DonePressed(_ sender: AnyObject) {
        guard let reps = set2Reps.text, let pounds = set2Pounds.text else {
            return
        }
        guard let intReps = Int(reps), let intPounds = Int(pounds) else {
            return
        }
        if intReps >= 0 && intPounds >= 0 {
            
            //Change to an overlay or something
            set2View.isHidden = true
            set3View.isHidden = false
            currentSetLabel.text = "Currently Set 3 of 3"
            
        }
        
    }
    
    @IBAction func set3DonePressed(_ sender: AnyObject) {
        guard let reps = set3Reps.text, let pounds = set3Pounds.text else {
            return
        }
        guard let intReps = Int(reps), let intPounds = Int(pounds) else {
            return
        }
        if intReps >= 0 && intPounds >= 0 {
            //Change to an overlay or something
            set3View.isHidden = true
            completedView.isHidden = false
            currentSetLabel.text = "Workout is Complete"
            completeButton.isEnabled = true
            //dismissKeyboard()
        }
    }
    
    @IBAction func completeButtonPressed(_ sender: AnyObject) {
        x.name = tempWorkout.name
        x.set1pounds = set1Pounds.text
        x.set1rep = set1Reps.text
        x.set2rep = set2Reps.text
        x.set2pounds = set2Pounds.text
        x.set3rep = set3Reps.text
        x.set3pounds = set3Pounds.text
        performSegue(withIdentifier: "confirmCompletedWorkout", sender: self)
    }
    
    func goToSegue() -> () {
        //let controller = FinishedWorkoutViewController()
        let vc: UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "testID"))!
        self.present(vc, animated: true, completion: nil)
        
        print("notif of goToSegueRecieved")
        //print(tempWorkout1.name)
        //present(controller, animated: true, completion: nil)
        //self.performSegue(withIdentifier: "confirmCompletedWorkout", sender: controller)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "confirmCompletedWorkout"{
            let newVC = segue.destination as? FinishedWorkoutViewController
            newVC?.x = x
            
        }
        
    }


}
