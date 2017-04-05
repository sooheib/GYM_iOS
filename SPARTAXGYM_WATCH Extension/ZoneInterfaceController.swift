//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation
import WatchKit

class ZoneInterfaceController: WKInterfaceController{
    
// MARK: - Overridden Public Methods
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let (workout, zone) = context as? (workout: Workout, zone: PulseZone) else{
            print("Error: unable to understand context in ZoneInterfaceController:awake")
            return
        }
        
        self.workout = workout
        self.zone = zone
        
        if UserDefaults.standard.string(forKey: UserDefaults.KeyZoneSelectionScreen) == zone.type.rawValue{
            becomeCurrentPage()
            
            initContent()
        }
        else{
            content.setHidden(true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){self.initContent()}
        }
    }
    
    override func didAppear() {
        UserDefaults.standard.setValue(zone.type.rawValue, forKey: UserDefaults.KeyZoneSelectionScreen)
    }
    
// MARK: - Private Properties
    
    fileprivate weak var workout: Workout!
    fileprivate weak var zone: PulseZone!
    
// MARK: - Private Methods
    
    fileprivate func initContent(){
        content.setHidden(false)
        
        self.initText()
    }
    
    fileprivate func initText(){
        setTitle("‹\(NSLocalizedString("Zones", comment: "Pulse Zones"))")
        
        zoneTitleLabel.setTextColor(zone.type.backgroundColor)
        zoneTitleLabel.setText(zone.type.title)
        
        //startButton.setBackgroundImage(zone.type.backgroundButtonImage)
        
        let attributedTitle = NSAttributedString(string: NSLocalizedString("START", comment: "START button title"), attributes: [NSForegroundColorAttributeName: zone.type.textColor])
        
        //startButton.setAttributedTitle(attributedTitle)
        
        zonePulseLevelLabel.setText(zone.type.userLevel)
        
        zonePulseRangeLabel.setTextColor(zone.type.backgroundColor2)
        
        if zone.type == PulseZoneType.z0{
            zonePulseRangeLabel.setText(NSLocalizedString("No pulse limits", comment: "Any pulse that user want"))
        }
        else{
            zonePulseRangeLabel.setText(String(format: NSLocalizedString("Pulse: %d-%d", comment: "Zone pulse range"), Int(zone.range.lowerBound), Int(zone.range.upperBound)))
        }
    }
    
// MARK: - IBOutlets
    @IBOutlet var content: WKInterfaceGroup!
    @IBOutlet var zoneTitleLabel: WKInterfaceLabel!
    @IBOutlet var zonePulseLevelLabel: WKInterfaceLabel!
    @IBOutlet var zonePulseRangeLabel: WKInterfaceLabel!
    @IBOutlet var startButton: WKInterfaceButton!
    
// MARK: - IBActions
    
    @IBAction func startSession() {
        let context = (workout: workout!, pulseZone: zone!)
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "CountdownTimer", context: context as AnyObject)])
        // For some unknown reason both two lines below crashes the editor and compiler!
        //        WKInterfaceController.reloadRootControllers(withNames: ["CountdownTimer"], contexts: [context])
        //        WKInterfaceController.reloadRootControllers(withNames: ["CountdownTimer"], contexts: [(workout: workout, program: program)])
    }
    
}
