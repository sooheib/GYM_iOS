//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class HistoryDayTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutName: UILabel!
    
    @IBOutlet weak var set1Rep: UILabel!
    @IBOutlet weak var set1Pounds: UILabel!
    
    @IBOutlet weak var set2Rep: UILabel!
    @IBOutlet weak var set2Pounds: UILabel!
    @IBOutlet weak var set3Rep: UILabel!
    @IBOutlet weak var set3Pounds: UILabel!
    
    @IBOutlet weak var didntFinishView: UIView!
    @IBOutlet weak var didNotFinishLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
