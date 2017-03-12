//
//  ClassesViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class ClassesViewController: SPParallaxTableViewController{
    
    
    // var classeslist=[Classes]()
    //var ref: FIRDatabaseReference!
    
    
    private let cellCount: Int = 24
    //  @IBOutlet weak var menuB: UIBarButtonItem!
    
    
    @IBOutlet weak var menuB: UIBarButtonItem!
    private var titles: [String]!
    private var subtitles: [String]!
    private var backgroundImages: [UIImage]!
    
    private var cellHeight: CGFloat = 240
    private var selectedCellHeight: CGFloat = 310
    
    private let cellIdentificator = "ParallaxTableViewCell"
    private var selectedCellIndex: IndexPath = IndexPath.init()
    
    private let normalCellGradeAlpha: CGFloat = 0.5
    private let selectedCellGradeAlpha: CGFloat = 0.2
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isHiddenStatusBar
    }
    
    private var isHiddenStatusBar: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if revealViewController() != nil {
            menuB.target = revealViewController()
            menuB.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.titles = DataAPI.getTitles()
        self.backgroundImages = DataAPI.getBackgroundImages()
        
        tableView.contentInset = UIEdgeInsetsMake(
            -cellHeight * 0.2,
            0, 0, 0
        );
        
        self.view.backgroundColor = UIColor.black
        self.tableView.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.isHidden = false
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        tableView.register(ParallaxTableViewCell.self, forCellReuseIdentifier: self.cellIdentificator)
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellCount
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        let offsetY = scrollView.contentOffset.y + 20 - cellHeight * 0.26
        if (offsetY > 20) {
            self.isHiddenStatusBar = false
        } else {
            self.isHiddenStatusBar = false
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentificator) as! ParallaxTableViewCell
        cell.parallaxSize = 150
        
        let x: Int = indexPath.row / self.backgroundImages.count
        let cellIndex = indexPath.row - x * self.backgroundImages.count
        
        cell.gradeView.alpha = self.normalCellGradeAlpha
        if indexPath == self.selectedCellIndex {
            cell.gradeView.alpha = self.selectedCellGradeAlpha
        }
        cell.backgroundImageView.image = self.backgroundImages[cellIndex]
        cell.titleLabel.text = self.titles[cellIndex]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedCellIndex {
            return self.selectedCellHeight
        }
        return self.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var needShowOpenAnimation: Bool = false
        
        if (selectedCellIndex == indexPath) {
            selectedCellIndex = IndexPath.init()
            needShowOpenAnimation = false
        } else {
            selectedCellIndex = indexPath
            needShowOpenAnimation = true
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        for cell in tableView.visibleCells {
            let parallaxCell = cell as! ParallaxTableViewCell
            
            SPAnimation.animate(
                0.3, animations: {
                    
                    parallaxCell.parallaxOffset(self.tableView)
                    parallaxCell.gradeView.alpha = self.normalCellGradeAlpha
                    parallaxCell.layoutIfNeeded()
                    
                }, options: [.curveEaseInOut]
            )
        }
        
        if needShowOpenAnimation {
            
            let cell = tableView.cellForRow(at: indexPath) as! ParallaxTableViewCell
            
            SPAnimation.animate(
                0.3, animations: {
                    
                    cell.gradeView.alpha = self.selectedCellGradeAlpha
                    cell.layoutIfNeeded()
                    
                }, options: [.curveEaseInOut]
            )
            
        }
    }
}
