//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class BottomOnlyBorderTextfield: UITextField {

    override func draw(_ rect: CGRect) {
        // Drawing code
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red:0.51, green:0.47, blue:0.96, alpha:1.0).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
 

}
