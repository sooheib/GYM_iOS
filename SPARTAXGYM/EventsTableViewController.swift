//
//  EventsTableViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import expanding_collection

class EventsTableViewController:  ExpandingTableViewController {
    
    fileprivate var scrollOffsetY: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        let image1 = UIImage.Asset.BackgroundImage.image
        tableView.backgroundView = UIImageView(image: image1)
    }
}
// MARK: Helpers

extension EventsTableViewController {
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}

// MARK: Actions

extension EventsTableViewController {
    
    @IBAction func backButtonHandler(_ sender: AnyObject) {
        // buttonAnimation
        let viewControllers: [EventsViewController?] = navigationController?.viewControllers.map { $0 as? EventsViewController } ?? []
        
        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(false)
            }
        }
        popTransitionAnimation()
    }
}

// MARK: UIScrollViewDelegate

extension EventsTableViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //    if scrollView.contentOffset.y < -25 {
        //      // buttonAnimation
        //      let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []
        //
        //      for viewController in viewControllers {
        //        if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
        //          rightButton.animationSelected(false)
        //        }
        //      }
        //      popTransitionAnimation()
        //    }
        
        scrollOffsetY = scrollView.contentOffset.y
    }
}
