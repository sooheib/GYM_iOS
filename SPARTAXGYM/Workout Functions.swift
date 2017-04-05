//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import Foundation
import Firebase

var currentworkout = "TEST WORKOUT"

var currentRep = 0
var currentSet = 0

var setupWorkoutSection = [String]()
var setupWorkoutDays = [[String]]()

var workoutToday = true
var numWorkoutsToday = 0

struct Workouts {
    var name: String?
    var set1rep: String?
    var set1pounds: String?
    var set2rep: String?
    var set2pounds: String?
    var set3rep: String?
    var set3pounds: String?
    var workoutComplete: String?
}

var tempWorkout = Workouts()


// Append the work outs for the next 7 days
func appendSetupWorkout() {
    setupWorkoutSection = []
    setupWorkoutDays = []
    var currentDayCount = -1
    
    let sevenDays = getDates()
    
    print(sevenDays)
    
    data.ref.child("users").child(userID!).child("days").observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        let value = snapshot.value as? [String: Any]
        
        
        for day in value!.keys.sorted() {
            for i in sevenDays {
                if day == i {
                    guard let workout1 = value![day] else {
                        break
                    }
                    let dict = workout1 as? [String : Any]
                    setupWorkoutSection.append(day)
                    setupWorkoutDays.append([])
                    currentDayCount += 1
                    for (workout, setRep) in dict! {
                        setupWorkoutDays[currentDayCount].append(workout)
                    }
                    
                }
            }
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier1"), object: nil)
        
    }) { (error) in
        print(error.localizedDescription)
    }
    
}


var historyDays = [String]()
var historyWorkouts = [[String]]()
var currentDayCount2 = 0
var workoutsFinished = 0
var workoutsTotal = 0


// Append workouts for the 7 previous days including today
func appendHistoryWorkouts() {
    currentDayCount2 = -1
    historyDays  = []
    historyWorkouts = []
    let sevenDays = getBackDates()
    
    
    data.ref.child("users").child(userID!).child("days").observeSingleEvent(of: .value, with: { (snapshot) in
        
        let value = snapshot.value as? [String: Any]
        
        
        for day in value!.keys.sorted().reversed() {
            for i in sevenDays {
                if day == i {
                    guard let workout1 = value![day] else {
                        break
                    }
                    let dict = workout1 as? [String : Any]
                    
                    workoutsFinished = 0
                    workoutsTotal = 0
                    
                    historyDays.append(day)
                    historyWorkouts.append([])
                    currentDayCount2 += 1
                    for (workout, setRep) in dict! {
                        workoutsTotal += 1
                        let dict2 = setRep as? [String: String]
                        for (key, value) in dict2! {
                            if key == "workoutComplete" {
                                if value == "true" {
                                    workoutsFinished += 1
                                    
                                }
                            }
                        }
                        
                        
                    }
                    historyWorkouts[currentDayCount2].append(String(workoutsFinished))
                    historyWorkouts[currentDayCount2].append(String(workoutsTotal))
                }
            }
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HistoryWorkoutsPosted"), object: nil)
        print(historyDays)
        print(historyWorkouts)
        
        
    }) { (error) in
        print(error.localizedDescription)
    }
    
    
}


// Getting the Number of todays workouts
func getTodaysWorkouts() {
    let today = get1Day()
    numWorkoutsToday = 0
    data.ref.child("users").child(userID!).child("days").child(today).observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        let value = snapshot.value as? [String: Any]
        
        
        if value == nil {
            workoutToday = false
        } else {
            for (_, _) in value! {
                numWorkoutsToday += 1
            }
            workoutToday = true
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WorkoutCountedForToday"), object: nil)
    }) { (error) in
        print(error.localizedDescription)
    }
}


// Function for the "Start Workout" Button. Appends the workouts for today
var todayWorkoutNumbers = 0
var todayWorkoutExercisesCompleted = [String : String]()
var todayWorkoutExercises = [String]()

func startTodaysWorkouts() {
    let today = get1Day()
    
    // Reset Numbers Each Call
    todayWorkoutNumbers = 0
    todayWorkoutExercises = []
    todayWorkoutExercisesCompleted = [:]
    
    
    data.ref.child("users").child(userID!).child("days").child(today).observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        let value = snapshot.value as? [String: Any]
        
        
        for (workout, repSetComplete) in value! {
            let repSetCompleteDict = repSetComplete as? [String: Any]
            let thisWorkoutComplete = repSetCompleteDict?["workoutComplete"]
            todayWorkoutExercises.append("\(workout)")
            todayWorkoutExercisesCompleted["\(workout)"] = "\(thisWorkoutComplete!)"
            
            
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TodaysWorkoutsPosted"), object: nil)
        
    }) { (error) in
        print(error.localizedDescription)
    }
}

var tempTodayWorkoutIndexPathRow = ""

func tempFiller() {
    
    var value = [String:Any]()
    let today = get1Day()
    
    data.ref.child("users").child(userID!).child("days").child(today).observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        value = snapshot.value as! [String: Any]
        
        for (workoutName, setRep) in value {
            let newValue = setRep as? [String: String]
            let chosenWork = tempTodayWorkoutIndexPathRow
            if workoutName == chosenWork{
                
                tempWorkout.set1rep = newValue?["set1Rep"]
                tempWorkout.set2rep = newValue?["set2Rep"]
                tempWorkout.set3rep = newValue?["set3Rep"]
                tempWorkout.set1pounds = newValue?["set1Pounds"]
                tempWorkout.set2pounds = newValue?["set2Pounds"]
                tempWorkout.set3pounds = newValue?["set3Pounds"]
                tempWorkout.name = String(chosenWork)
                
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempFilled"), object: nil)
    }) { (error) in
        print(error.localizedDescription)
    }
}

var dayHistoryWorkouts = [Workouts]()
var tempHistoryDay = ""

// Function to return date of the history workout.
func choseHistoryWorkoutDay() {
    print("choseHIstoryWorkoutDay")
    var value = [String:Any]()
    dayHistoryWorkouts = []
    
    var tempHistoryWorkout = Workouts()
    
    data.ref.child("users").child(userID!).child("days").child(tempHistoryDay).observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        value = snapshot.value as! [String: Any]
        
        for (workoutName, setRep) in value {
            let newValue = setRep as? [String: String]
            
            tempHistoryWorkout.set1rep = newValue?["set1Rep"]
            tempHistoryWorkout.set2rep = newValue?["set2Rep"]
            tempHistoryWorkout.set3rep = newValue?["set3Rep"]
            tempHistoryWorkout.set1pounds = newValue?["set1Pounds"]
            tempHistoryWorkout.set2pounds = newValue?["set2Pounds"]
            tempHistoryWorkout.set3pounds = newValue?["set3Pounds"]
            tempHistoryWorkout.name = workoutName
            tempHistoryWorkout.workoutComplete = newValue?["workoutComplete"]
            dayHistoryWorkouts.append(tempHistoryWorkout)
            
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tempHistoryFilled"), object: nil)
    }) { (error) in
        print(error.localizedDescription)
    }
    
}

