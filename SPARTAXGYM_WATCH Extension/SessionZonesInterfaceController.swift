//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation
import WatchKit
import HealthKit

class SessionZonesInterfaceController: WKInterfaceController{
    
// MARK: - Overridden Public Methods
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        workoutSessionManager.multicastDelegate.addDelegate(self)
        
        content.setHidden(true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){self.initContent()}
    }
    
// MARK: - Private Properties

    fileprivate weak var pulseZone1: PulseZone?
    fileprivate weak var pulseZone2: PulseZone?
    fileprivate weak var pulseZone3: PulseZone?
    fileprivate weak var pulseZone4: PulseZone?

// MARK: - Private Computed Properties
    
    fileprivate var workoutSessionManager: WorkoutSessionManager{
        get{
            return ((WKExtension.shared().delegate as? ExtensionDelegate)?.workoutSessionManager)!
        }
    }
    
// MARK: - Private Methods
    
    fileprivate func initContent(){
        content.setHidden(false)
        
        initText()
        
        updateZoneButtons()
    }
    
    fileprivate func initText(){
        if let title = workoutSessionManager.workoutProgram?.title{
            setTitle(title)
        }
        else{
            setTitle("")
        }
        
    }
    
    fileprivate func updateZoneButtons(){
        guard let currentPulseZone = workoutSessionManager.currentPulseZone else{
            print("Error: there is no currentPulseZone")
            return
        }
        
        guard let pulseZones = (WKExtension.shared().delegate as? ExtensionDelegate)?.pulseZones else{
            print("Error: there is no pulseZones")
            return
        }
        
        var zones = [pulseZones.pulseZone(forType: PulseZoneType.z1),
                     pulseZones.pulseZone(forType: PulseZoneType.z2),
                     pulseZones.pulseZone(forType: PulseZoneType.z3),
                     pulseZones.pulseZone(forType: PulseZoneType.z4),
                     pulseZones.pulseZone(forType: PulseZoneType.z0)]
        
        if let currentPulseZoneIndex = zones.index(of: currentPulseZone){
            zones.remove(at: currentPulseZoneIndex)
        }
        
        func applyChanges(_ zoneButton: WKInterfaceButton, _ pulseZone: inout PulseZone?, _ index: Int){
            
          zoneButton.setAttributedTitle(NSAttributedString(string: zones[index].type.shortTitle, attributes: [NSForegroundColorAttributeName: zones[index].type.textColor]))
            //zoneButton.setBackgroundImage(zones[index].type.backgroundImage)
            pulseZone = zones[index]
        }
        
        applyChanges(zoneButton1, &pulseZone1, 0)
        applyChanges(zoneButton2, &pulseZone2, 1)
        applyChanges(zoneButton3, &pulseZone3, 2)
        applyChanges(zoneButton4, &pulseZone4, 3)
    }
    
    fileprivate func showSessionInfo(){
        NotificationCenter.default.post(Notification(name: NSNotification.Name.ShowSessionInfoInterfaceController))
    }
    
// MARK: - IBOutlets
    
    @IBOutlet var content: WKInterfaceGroup!
    
    @IBOutlet var zoneButton1: WKInterfaceButton!
    @IBOutlet var zoneButton2: WKInterfaceButton!
    @IBOutlet var zoneButton3: WKInterfaceButton!
    @IBOutlet var zoneButton4: WKInterfaceButton!
    
// MARK: - IBActions
    
    @IBAction func zoneButton1Selected(){
        workoutSessionManager.currentPulseZone = pulseZone1
        showSessionInfo()
    }
    
    @IBAction func zoneButton2Selected(){
        workoutSessionManager.currentPulseZone = pulseZone2
        showSessionInfo()
    }
    
    @IBAction func zoneButton3Selected(){
        workoutSessionManager.currentPulseZone = pulseZone3
        showSessionInfo()
    }
    
    @IBAction func zoneButton4Selected(){
        workoutSessionManager.currentPulseZone = pulseZone4
        showSessionInfo()
    }
}

extension SessionZonesInterfaceController: WorkoutSessionManagerDelegate{
    func workoutSessionManager(_ workoutSessionManager: WorkoutSessionManager, pulseZoneDidChangeTo toPulseZone: PulseZone, from fromPulseZone: PulseZone) {
        
        updateZoneButtons()
    }
}
