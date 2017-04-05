//
//  ClassesViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import Firebase


class ClassesViewController: SPParallaxTableViewController{
    
    

    
    @IBOutlet var tableviewclasses: UITableView!
    
    var refClasses: FIRDatabaseReference!
    
    
    //list to store all the artist
    var classesList = [Courses]()
    
    
    private let cellCount: Int = 24
    //  @IBOutlet weak var menuB: UIBarButtonItem!
    
    
    @IBOutlet weak var menuB: UIBarButtonItem!
    private var titles: [String]!
    private var subtitles: [String]!
    private var backgroundImages: [UIImage]!
    private var Imm: [UIImage]!
    var image: UIImageView!

    
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
        
        if FIRApp.defaultApp() == nil {
            FIRApp.configure()
        }
                refClasses = FIRDatabase.database().reference().child("classes");
        
        
        
        
                //observing the data changes
                refClasses.observe(FIRDataEventType.value, with: { (snapshot) in
        
                    //if the reference have some values
                    if snapshot.childrenCount > 0 {
        
                        //clearing the list
                        self.classesList.removeAll()
        
                        //iterating through all the values
                        for classes in snapshot.children.allObjects as! [FIRDataSnapshot] {
                            //getting values
                            let classObject = classes.value as? [String: AnyObject]
                            let className  = classObject?["course_name"]
                            //let  classDesc = classObject?["course_desc"]
                            let classCover = classObject?["course_cover"]
        
                            //creating artist object with model and fetched values
                            //let course = Classes(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String?)
        
                            let course =  Courses(namecourse:className as! String?,covercourse:classCover as! String?)
        
                            //appending it to list
                            self.classesList.append(course)
                        }
                        
                        //reloading the tableview
                        self.tableviewclasses.reloadData()
                    }
                })
                
        
        
        
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
        //return self.cellCount
        return classesList.count

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
    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        imageView.alpha = 0
                        
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
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
       // cell.backgroundImageView.image = self.backgroundImages[cellIndex]
       // cell.titleLabel.text = self.titles[cellIndex]
        

        
        
        //////
        
        
        //creating a cell using the custom class
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //the artist object
        let classes: Courses
        
        //getting the class of selected position
          classes = classesList[cellIndex]
        
        //adding values to labels
        cell.titleLabel.text = classes.course_name
        
        print(classes.course_cover)
       // get_image(classes.course_cover!, image)
        
        
        let imageUrl:URL = URL(string: classes.course_cover!)!
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
            imageView.center = self.view.center
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell.backgroundImageView.image = image
                
               // imageView.contentMode = UIViewContentMode.scaleAspectFit
               // self.view.addSubview(imageView)
            }
        }
        
        
        
        //cell.backgroundImageView.image = image.image
        
        
        //////
        
        
        
        
        
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
