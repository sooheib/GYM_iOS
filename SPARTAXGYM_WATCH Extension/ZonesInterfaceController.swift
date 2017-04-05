//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/25/17.
//  Copyright © 2017 souheib. All rights reserved.
//


import Foundation
import WatchKit

class ZonesInterfaceController: WKInterfaceController{
    
// MARK: - Overridden Public Methods
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let (workout, _) = context as? (workout: Workout, program: WorkoutProgram?) else{
            print("Error: unable to understand context in ZonesInterfaceController:awake")
            return
        }
        
        self.workout = workout
        
        if UserDefaults.standard.string(forKey: UserDefaults.KeyProgramSelectionScreen) == "Zones"{
            becomeCurrentPage()
            
            initContent()
        }
        else{
            content.setHidden(true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0){self.initContent()}
        }
    }
    
    override func didAppear() {
        UserDefaults.standard.setValue("Zones", forKey: UserDefaults.KeyProgramSelectionScreen)
    }
    
// MARK: - Private Properties
    
    fileprivate weak var workout: Workout!
    
// MARK: - Private Methods
    
    fileprivate func initContent(){
        content.setHidden(false)
        
        setTitle("‹\(workout.title)")
        
        initText()
        initZones()
    }
    
    fileprivate func initText(){
        
        headerLabel.setText(NSLocalizedString("Pulse Zones", comment: "Pulse Zones"))
        
        durationLabel.setText(NSLocalizedString("Time free", comment: "Time free"))
        
        //selectButton.setBackgroundImage(PulseZoneType.z2.backgroundButtonImage)
        
        let attributedTitle = NSAttributedString(string: NSLocalizedString("SELECT", comment: "SELECT button title"), attributes: [NSForegroundColorAttributeName: PulseZoneType.z2.textColor])
        
        //selectButton.setAttributedTitle(attributedTitle)
    }
    
    fileprivate func initZones(){
        guard let zones = (WKExtension.shared().delegate as? ExtensionDelegate)?.pulseZones.zones else{
            print("Error: there is no zones")
            return
        }
        
        let zoneLabels = [PulseZoneType.z1: z1Label,
                          PulseZoneType.z2: z2Label,
                          PulseZoneType.z3: z3Label,
                          PulseZoneType.z4: z4Label]
        let zoneGroups = [PulseZoneType.z1: z1Group,
                          PulseZoneType.z2: z2Group,
                          PulseZoneType.z3: z3Group,
                          PulseZoneType.z4: z4Group]
        
        for zone in zones.keys{
            if zone != PulseZoneType.z0{
                zoneLabels[zone]??.setText(zone.shortTitle)
                zoneLabels[zone]??.setTextColor(zone.textColor)
                
                zoneGroups[zone]??.setBackgroundImage(zone.backgroundImage)
            }
        }
    }
    
// MARK: - IBOutlets
    
    @IBOutlet var content: WKInterfaceGroup!
    
    @IBOutlet var headerLabel: WKInterfaceLabel!
    @IBOutlet var selectButton: WKInterfaceButton!
    @IBOutlet var z1Label: WKInterfaceLabel!
    @IBOutlet var z2Label: WKInterfaceLabel!
    @IBOutlet var z3Label: WKInterfaceLabel!
    @IBOutlet var z4Label: WKInterfaceLabel!
    
    @IBOutlet var z1Group: WKInterfaceGroup!
    @IBOutlet var z2Group: WKInterfaceGroup!
    @IBOutlet var z3Group: WKInterfaceGroup!
    @IBOutlet var z4Group: WKInterfaceGroup!
    
    @IBOutlet var durationLabel: WKInterfaceLabel!
    
// MARK: - IBActions
    
    @IBAction func selectZone() {
        guard let pulseZones = (WKExtension.shared().delegate as? ExtensionDelegate)?.pulseZones else{
            print("Error: there is no pulseZones")
            return
        }
        
        let names = Array<String>.init(repeating: "Zone", count: 5)
        
        var contexts = Array<(workout: Workout, zone: PulseZone)>()
        contexts.append((workout: workout, zone: pulseZones.pulseZone(forType: PulseZoneType.z1)))
        contexts.append((workout: workout, zone: pulseZones.pulseZone(forType: PulseZoneType.z2)))
        contexts.append((workout: workout, zone: pulseZones.pulseZone(forType: PulseZoneType.z3)))
        contexts.append((workout: workout, zone: pulseZones.pulseZone(forType: PulseZoneType.z4)))
        contexts.append((workout: workout, zone: pulseZones.pulseZone(forType: PulseZoneType.z0)))
        
        presentController(withNames: names, contexts: contexts)
    }
    
}
