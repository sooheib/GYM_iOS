//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation
import HealthKit

class Workout{
    
// MARK: - Initializers
    
    init(configuration: HKWorkoutConfiguration) {
        self.configuration = configuration
        
    }

// MARK: - Public Properties
    
    var configuration: HKWorkoutConfiguration
    
// MARK: - Public Computed Properties
    
    var title: String{
        get{
            var result: String = ""
            switch configuration.locationType {
            case .outdoor:
                result += NSLocalizedString("Outdoor", comment: "Location type of the workout. Used as a part of the workout title in combination with activity type (running, walking, etc.)")
            case .indoor:
                result += NSLocalizedString("Indoor", comment: "Location type of the workout. Used as a part of the workout title in combination with activity type (running, walking, etc.)")
            default:
                break
            }
            
            result += " "
            
            switch configuration.activityType {
            case .running:
                result += NSLocalizedString("Run", comment: "Activity type of the workout. Used as a part of the workout title in combination with location type (outdoor or indoor)")
            default:
                break
            }
            
            return result
        }
    }
}
