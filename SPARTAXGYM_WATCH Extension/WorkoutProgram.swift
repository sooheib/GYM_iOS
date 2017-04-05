//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation

class WorkoutProgram{
    
// MARK: - Initializers
    
    init(title: String, parts: [WorkoutProgramPart]){
        self.title = title
        self.parts = parts
    }
    
// MARK: - Public Properties
    
    var title: String
    var parts: [WorkoutProgramPart]
    
    var duration: TimeInterval{
        get{
            return self.parts.last?.endTime ?? 0
        }
    }
    
// MARK: - Public Computed Properties
    
    var firstPart: WorkoutProgramPart{
        get{
            return parts.first!
        }
    }
    
// MARK: - Public Methods
    
    func part(forTime time: TimeInterval) -> WorkoutProgramPart?{
        for part in parts{
            if part.contains(time: time){
                return part
            }
        }
        
        return nil
    }
}
