//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/8/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override func draw(_ rect: CGRect) {
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
       let startColor: UIColor = UIColor(red: 82/255, green: 82/255, blue: 79/255, alpha: 1)
        
        //UIColor.init(red: 82/255, green: 82/255, blue: 79/255, alpha: 1)
        
     let endColor: UIColor = UIColor(red: 82/255, green: 82/255, blue: 79/255, alpha: 1)
    let colors = [startColor.cgColor, endColor.cgColor]
        let locations: [CGFloat] = [0, 1]
        let gradient: CGGradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!
        
        let startPoint: CGPoint = CGPoint(x:rect.midX, y: rect.minY)
        let endPoint: CGPoint = CGPoint(x: rect.midX, y: rect.maxY)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        context.restoreGState()
    }

}
