//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation
import UIKit

enum PulseZoneType: String{
    case z0
    case z1
    case z2
    case z3
    case z4

// MARK: - Public Computed Properties
    
    var title: String{
        get{
            switch self {
            case .z0:
                return NSLocalizedString("Zone 0", comment: "Any pulse zone")
            case .z1:
                return NSLocalizedString("Zone 1", comment: "Pulse Zone 1")
            case .z2:
                return NSLocalizedString("Zone 2", comment: "Pulse Zone 2")
            case .z3:
                return NSLocalizedString("Zone 3", comment: "Pulse Zone 3")
            case .z4:
                return NSLocalizedString("Zone 4", comment: "Pulse Zone 4")
            }
        }
    }
    
    var shortTitle: String{
        get{
            switch self {
            case .z0:
                return NSLocalizedString("Z0", comment: "Any pulse zone short name (2 characters)")
            case .z1:
                return NSLocalizedString("Z1", comment: "Pulse Zone 1 short name (2 characters)")
            case .z2:
                return NSLocalizedString("Z2", comment: "Pulse Zone 2 short name (2 characters)")
            case .z3:
                return NSLocalizedString("Z3", comment: "Pulse Zone 3 short name (2 characters)")
            case .z4:
                return NSLocalizedString("Z4", comment: "Pulse Zone 4 short name (2 characters)")
            }
        }
    }
    
    var userLevel: String{
        get{
            switch self {
            case .z0:
                return NSLocalizedString("Free Run", comment: "User level short description for Z0 (zone for free running without limits)")
            case .z1:
                return NSLocalizedString("Warming Up", comment: "User level short description for Z1 (zone for warming up exercises)")
            case .z2:
                return NSLocalizedString("Beginner", comment: "User level short description for Z2 (zone for beginners)")
            case .z3:
                return NSLocalizedString("Advanced", comment: "User level short description for Z2 (zone for advanced runners)")
            case .z4:
                return NSLocalizedString("Professional", comment: "User level short description for Z2 (zone only for professional runners)")
            }
        }
    }
    
    var backgroundColor: UIColor{
        get{
            switch self {
            case .z0:
//                return UIColor.init(red: 0.902, green: 0.902, blue: 0.902, alpha: 1.000) // e6e6e6
                return UIColor.init(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000) // ffffff
            case .z1:
                return UIColor.init(red: 0.649, green: 1.000, blue: 0.000, alpha: 1.000) // a5ff00
            case .z2:
                return UIColor.init(red: 1.000, green: 0.587, blue: 0.000, alpha: 1.000) // ff9600
            case .z3:
                return UIColor.init(red: 0.645, green: 0.000, blue: 0.645, alpha: 1.000) // a400a4
            case .z4:
                return UIColor.init(red: 0.980, green: 0.069, blue: 0.311, alpha: 1.000) // fa124f
            }
        }
    }
    
    var backgroundColor2: UIColor{
        get{
            switch self {
            case .z0:
                return UIColor.init(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000) // ffffff
            case .z1:
                return UIColor.init(red: 0.784, green: 1.000, blue: 0.400, alpha: 1.000) // c8ff66
            case .z2:
                return UIColor.init(red: 1.000, green: 0.651, blue: 0.149, alpha: 1.000) // ffa626
            case .z3:
                return UIColor.init(red: 0.851, green: 0.212, blue: 0.851, alpha: 1.000) // d936d9
            case .z4:
                return UIColor.init(red: 0.980, green: 0.196, blue: 0.404, alpha: 1.000) // fa3267
            }
        }
    }
    
    var backgroundImage: UIImage?{
        get{
            switch self {
            case .z0:
                return UIImage(named: "z0-background")
            case .z1:
                return UIImage(named: "z1-background")
            case .z2:
                return UIImage(named: "z2-background")
            case .z3:
                return UIImage(named: "z3-background")
            case .z4:
                return UIImage(named: "z4-background")
            }
        }
    }
    
    var backgroundButtonImage: UIImage?{
        get{
            switch self {
            case .z0:
                return UIImage(named: "z0-button-background")
            case .z1:
                return UIImage(named: "z1-button-background")
            case .z2:
                return UIImage(named: "z2-button-background")
            case .z3:
                return UIImage(named: "z3-button-background")
            case .z4:
                return UIImage(named: "z4-button-background")
            }
        }
    }
    
    var textColor: UIColor{
        get{
            switch self {
            case .z0:
                return UIColor.init(red: 1.000 , green: 0.587, blue: 0.000, alpha: 1.000)
            case .z1, .z2, .z3, .z4:
                return UIColor.init(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
            }
        }
    }
}
