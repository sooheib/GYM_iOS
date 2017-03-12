//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/8/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class TrainersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    
    fileprivate var items = [Character]()
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            let character = self.items[self.currentPage]
            self.infoLabel.text = character.name.uppercased()
            self.detailLabel.text = character.movie.uppercased()
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    fileprivate var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.setupLayout()
        self.items = self.createItems()
        
        self.currentPage = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(TrainersViewController.rotationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    fileprivate func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    
    fileprivate func createItems() -> [Character] {
        let characters = [
            Character(imageName: "Photo", name: "Souheib Selmi", movie: "PILATES"),
            Character(imageName: "paul", name: "Mounir", movie: "TAEBO"),
            Character(imageName: "kirill", name: "AAAA", movie: "YOGA"),
            Character(imageName: "kate", name: "Habiba", movie: "CARDIO"),
            Character(imageName: "julia", name: "Islem", movie: "ZUMBA"),
            Character(imageName: "anastasia", name: "Aalia", movie: "SALSA")
        ]
        return characters
    }
    
    
    @objc fileprivate func rotationDidChange() {
        guard !orientation.isFlat else { return }
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let direction: UICollectionViewScrollDirection = UIDeviceOrientationIsPortrait(orientation) ? .horizontal : .vertical
        layout.scrollDirection = direction
        if currentPage > 0 {
            let indexPath = IndexPath(item: currentPage, section: 0)
            let scrollPosition: UICollectionViewScrollPosition = UIDeviceOrientationIsPortrait(orientation) ? .centeredHorizontally : .centeredVertically
            self.collectionView.scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        }
    }
    
    // MARK: - Card Collection Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
        let character = items[(indexPath as NSIndexPath).row]
        cell.image.image = UIImage(named: character.imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = items[(indexPath as NSIndexPath).row]
        let alert = UIAlertController(title: character.name, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
}

