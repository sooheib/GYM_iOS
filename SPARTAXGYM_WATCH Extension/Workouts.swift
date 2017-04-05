//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import Foundation
import HealthKit

class Workouts{

// MARK: - Initializers
    
    init(){
        allWorkouts = []
        
        let configuration1 = HKWorkoutConfiguration()
        configuration1.activityType = HKWorkoutActivityType.running
        configuration1.locationType = .outdoor
        let workout1 = Workout(configuration: configuration1)
        allWorkouts.append(workout1)
        
        let configuration2 = HKWorkoutConfiguration()
        configuration2.activityType = HKWorkoutActivityType.running
        configuration2.locationType = .indoor
        let workout2 = Workout(configuration: configuration2)
        allWorkouts.append(workout2)
    }
    
// MARK: - Public Properties
    
    var allWorkouts: [Workout]

}
