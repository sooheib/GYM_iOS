//
//  EventsViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import expanding_collection


class EventsViewController: ExpandingViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    typealias ItemInfo = (imageName: String, title: String)
    fileprivate var cellsIsOpen = [Bool]()
    fileprivate let items: [ItemInfo] = [("zumba", "Zumba"),("salsa", "Salsa"),("yoga", "Yoga"),("fitness", "fitness")]
    
    @IBOutlet weak var pageLabel: UILabel!
}

// MARK: life cicle

extension EventsViewController {
    
    override func viewDidLoad() {
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        itemSize = CGSize(width: 256, height: 335)
        super.viewDidLoad()
        
        registerCell()
        fillCellIsOpeenArry()
        addGestureToView(collectionView!)
        //configureNavBar()
    }
}

// MARK: Helpers

extension EventsViewController {
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: DemoCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: DemoCollectionViewCell.self))
    }
    
    fileprivate func fillCellIsOpeenArry() {
        for _ in items {
            cellsIsOpen.append(false)
        }
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: EventsTableViewController = storyboard.instantiateViewController()
        return toViewController
    }
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}

/// MARK: Gesture

extension EventsViewController {
    
    fileprivate func addGestureToView(_ toView: UIView) {
        /*let gesutereUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
         $0.direction = .up
         }*/
        
        /* let gesutereDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
         $0.direction = .down
         }*/
        //toView.addGestureRecognizer(gesutereUp)
        // toView.addGestureRecognizer(gesutereDown)
    }
    
    func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell  = collectionView?.cellForItem(at: indexPath) as? DemoCollectionViewCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[(indexPath as NSIndexPath).row] = cell.isOpened
    }
}

// MARK: UIScrollViewDelegate

extension EventsViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageLabel.text = "\(currentIndex+1)/\(items.count)"
    }
}

// MARK: UICollectionViewDataSource

extension EventsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? DemoCollectionViewCell else { return }
        
        let index = (indexPath as NSIndexPath).row % items.count
        let info = items[index]
        cell.backgroundImageView?.image = UIImage(named: info.imageName)
        cell.customTitle.text = info.title
        cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DemoCollectionViewCell
            , currentIndex == (indexPath as NSIndexPath).row else { return }
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            pushToViewController(getViewController())
            
            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(true)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension EventsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DemoCollectionViewCell.self), for: indexPath)
    }
}
