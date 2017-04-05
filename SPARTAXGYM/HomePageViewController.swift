//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import Firebase

class HomePageViewController: UIViewController {
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var numOfWorkoutsToday: UILabel!
    @IBOutlet weak var startWorkoutButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    
    let todaysWorkout = 0
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
        
//        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
//            if let user = user {
//                
//            } else {
//                self.performSegue(withIdentifier: "goToLogin", sender: self)
//            }
//        }
        
        if FIRApp.defaultApp() == nil {
            FIRApp.configure()
        }
        
        activityIndicator.isHidden = true
        //var historyDates = getBackDates()
        //print(historyDates)

        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            getTodaysWorkouts()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotifications(notification:)), name: NSNotification.Name(rawValue: "NotificationIdentifier1"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setNumWorkouts(notification:)), name: NSNotification.Name(rawValue: "WorkoutCountedForToday"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.startTodaysWorkoutsNotif), name: NSNotification.Name(rawValue: "TodaysWorkoutsPosted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.historyWorkoutsNotif), name: NSNotification.Name(rawValue: "HistoryWorkoutsPosted"), object: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NotificationIdentifier1"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "WorkoutCountedForToday"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "TodaysWorkoutsPosted"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "HistoryWorkoutsPosted"), object: nil)
    }
    
    func setNumWorkouts(notification: NSNotification) {
        if workoutToday == false {
            numOfWorkoutsToday.text = "0"
            startWorkoutButton.isEnabled = false
        } else {
            startWorkoutButton.isEnabled = true
        }
        numOfWorkoutsToday.text = "\(numWorkoutsToday)"
    }
    
    
    @IBAction func settingsPressed(_ sender: AnyObject) {
        if settingsView.isHidden == true {
            settingsView.isHidden = false
        } else {
            settingsView.isHidden = true
        }
        
    }
    @IBAction func signOutPressed(_ sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        //performSegue(withIdentifier: "goToLogin", sender: self)
    }

    @IBAction func setupWorkoutsPressed(_ sender: AnyObject) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        appendSetupWorkout()
        
        
    }
    
    func methodOfReceivedNotifications(notification: NSNotification){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        self.performSegue(withIdentifier: "setupWorkoutSegue", sender: self)

    }
    
    @IBAction func startWorkoutPressed(_ sender: AnyObject) {
        startTodaysWorkouts()
        thisDateToday = get1Day()
    }
    
    
    func startTodaysWorkoutsNotif() {
        self.performSegue(withIdentifier: "startWorkoutSegue", sender: self)
    }
    
    @IBAction func workoutHistoryPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        appendHistoryWorkouts()
        
    }
    
    func historyWorkoutsNotif() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        self.performSegue(withIdentifier: "historyWorkoutSegue", sender: self)
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
