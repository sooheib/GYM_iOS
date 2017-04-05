//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation

class WorkoutProgramPart: NSObject{
    
// MARK: - Initializers
    
    init(pulseZoneType: PulseZoneType, duration: TimeInterval, startTime: TimeInterval) {
        self.pulseZoneType = pulseZoneType
        self.duration = duration
        self.startTime = startTime
        self.endTime = startTime + duration
    }
    
// MARK: - Public Properties
    
    var pulseZoneType: PulseZoneType
    var duration: TimeInterval
    var startTime: TimeInterval
    var endTime: TimeInterval

// MARK: - Public Methods
    
    func contains(time: TimeInterval) -> Bool{
        return (startTime <= time && time < endTime) ? true : false
    }
}
