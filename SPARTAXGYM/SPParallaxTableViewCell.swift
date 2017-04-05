//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/8/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class SPParallaxTableViewCell: UITableViewCell {
    
    var parallaxViews = [UIView]()
    var parallaxSize: CGFloat = 100
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = true
        self.selectionStyle = .none
    }
    
    func parallaxOffset(_ tableView: UITableView) {
        //place in parallax-position
        var deltaY = (frame.origin.y + frame.height/2) - tableView.contentOffset.y
        deltaY = min(tableView.bounds.height, max(deltaY, 0))
        var move : CGFloat = (deltaY / tableView.bounds.height) * self.parallaxSize
        move = move / 2.0  - move
        for view in self.parallaxViews {
            view.frame.origin.y = move
        }
    }
}
