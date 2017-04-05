//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation

class PulseZone: NSObject {
    
// MARK: - Type Computed Properties
    
    static var Z0: PulseZone{
        get{
            return PulseZone(.z0, pulsRange: 0...200)
        }
    }

// MARK: - Initializers
    
    init(_ type: PulseZoneType, pulsRange: ClosedRange<Double>) {
        self.pulsType = type
        self.pulsRange = pulsRange
    }
    
// MARK: - Public Computed Properties
    
    var type: PulseZoneType{
        get{
            return pulsType
        }
    }
    
    var range: ClosedRange<Double>{
        get{
            return pulsRange
        }
    }
    
// MARK: - Private Properties
    
    fileprivate var pulsType: PulseZoneType
    fileprivate var pulsRange: ClosedRange<Double>
    
}

