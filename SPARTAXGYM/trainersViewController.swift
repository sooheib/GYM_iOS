//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/8/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import Firebase


class TrainersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var refTrainers: FIRDatabaseReference!

    @IBOutlet var collectionViewTrainers: UICollectionView!

        static var isAlreadyLaunchedOnce = false // Used to avoid 2 FIRApp configure
    
    //list to store all the artist
    var trainersList = [Trainer]()

    
    fileprivate var items = [Character]()
    
 
    
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
        
     
        
        if FIRApp.defaultApp() == nil {
            FIRApp.configure()
        }
        
        
        
        //FIRApp.configure()
        
        refTrainers = FIRDatabase.database().reference().child("trainers");
        
        
        
        
        //observing the data changes
        refTrainers.observe(FIRDataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.trainersList.removeAll()
                
                //iterating through all the values
                for classes in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    //getting values
                    let classObject = classes.value as? [String: AnyObject]
                    let className  = classObject?["trainer_name"]
                    //let  classDesc = classObject?["course_desc"]
                    let classCover = classObject?["trainer_photo"]
                    
                    //creating artist object with model and fetched values
                    //let course = Classes(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String?)
                    
                    let trainer =  Trainer(nametrainer:className as! String?,covertrainer:classCover as! String?)
                    
                    //appending it to list
                    self.trainersList.append(trainer)
                }
                
                //reloading the tableview
        self.collectionViewTrainers.reloadData()
            }
        })

        
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
    
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            
            
            if trainersList.count == 0{
            
                let character = self.items[self.currentPage]
                self.infoLabel.text = character.name.uppercased()
                self.detailLabel.text = character.movie.uppercased()
            }
            else
            
            {
            
                 let trainer1=self.trainersList[self.currentPage]
                 self.infoLabel.text=trainer1.trainer_name?.uppercased()
                 self.detailLabel.text = trainer1.trainer_desc?.uppercased()
            
            }
            
            
            
 
            
            
        }
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
        //return items.count
        return trainersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
        //let character = items[(indexPath as NSIndexPath).row]
       // cell.image.image = UIImage(named: character.imageName)
        
        let cellIndex=(indexPath as NSIndexPath).row
        
        let trainers:Trainer
        trainers = trainersList[cellIndex]
        
        let imageUrl:URL = URL(string: trainers.trainer_cover!)!
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
            imageView.center = self.view.center
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                
                cell.image.image = image

        
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let character = items[(indexPath as NSIndexPath).row]
        
        //let alert = UIAlertController(title: character.name, message: nil, preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //present(alert, animated: true, completion: nil)
        let cellIndex=(indexPath as NSIndexPath).row

        let trainers:Trainer
        trainers = trainersList[cellIndex]
    
        let alert = UIAlertController(title: trainers.trainer_name, message: nil, preferredStyle: .alert)
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

