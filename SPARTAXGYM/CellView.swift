//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import Foundation
import JTAppleCalendar
import UIKit

class CellView2: JTAppleDayCellView {
    @IBOutlet var dayLabel: UILabel!
    var normalDayColor = UIColor.white
    var weekendDayColor = UIColor.gray
    var selectedColor = UIColor.black
    @IBOutlet weak var selectedBubbleImage: UIImageView!
    
    
    
    func setupCellBeforeDisplay(cellState: CellState, date: Date) {
        // Setup Cell text
        dayLabel.text =  cellState.text
        
        // Setup text color
        
        configureTextColor(cellState: cellState)
        
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth && cellState.isSelected && Int(dayLabel.text!)! == day {
            //dayLabel.textColor = selectedColor
            dayLabel.isHidden = false
            self.isUserInteractionEnabled = true
            //dayLabel.textColor = selectedColor
            selectedBubbleImage.isHidden = false
            /*if borrowedVC.monthNameLabel.text == whatMonth(month: month) {
                dayLabel.textColor = selectedColor
                print(whatMonth(month: month))
            }*/
        } else if cellState.dateBelongsTo == .thisMonth && cellState.isSelected && Int(dayLabel.text!)! != day{
            dayLabel.isHidden = false
            self.isUserInteractionEnabled = true
            //dayLabel.textColor = selectedColor
            selectedBubbleImage.isHidden = false
            dayLabel.textColor = normalDayColor
        } else if cellState.dateBelongsTo == .thisMonth && cellState.isSelected == false && Int(dayLabel.text!)! == day {
            
            selectedBubbleImage.isHidden = true
            dayLabel.isHidden = false
            self.isUserInteractionEnabled = true
            
            
            /*
            if borrowedVC.monthNameLabel.text == whatMonth(month: month) {
                dayLabel.textColor = selectedColor
                print(whatMonth(month: month))
            }*/
        
        } else if cellState.dateBelongsTo == .thisMonth && cellState.isSelected == false && Int(dayLabel.text!)! != day {
            selectedBubbleImage.isHidden = true
            dayLabel.isHidden = false
            self.isUserInteractionEnabled = true
            dayLabel.textColor = normalDayColor
        } else {
            dayLabel.isHidden = true
            self.isUserInteractionEnabled = false
            selectedBubbleImage.isHidden = true
        }
    }
    
    func cellSelectionChanged(cellState: CellState) {
        if cellState.isSelected {
            //dayLabel.textColor = normalDayColor
            selectedBubbleImage.isHidden = true
        } else {
            //dayLabel.textColor = selectedColor
            selectedBubbleImage.isHidden = false
        }
    }
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
