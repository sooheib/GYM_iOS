//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//
import UIKit

class BodyChoiceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //  configureView()
        
        // Configure Nav Bar for Next Tab
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "< ", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton;
        super.viewWillAppear(animated);
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureView() {
        //let navBarFont = UIFont(name: "OpenSans", size: 20.0)
     //   let navBarAttributesDictionary: [String: AnyObject]? = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: navBarFont!]
        
      //  navigationController?.navigationBar.barTintColor = UIColor(red:0.16, green:0.18, blue:0.23, alpha:1.0)
        //navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
       // tableView.rowHeight = 80
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return defaultWorkouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theWorkout") as! BodyChoiceTableViewCell
        
        cell.bodyChoice.text = defaultWorkouts[indexPath.row]
        
        
        // Configure the cell...
        
        return cell
    }



    
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showBodyChoice" {
            if let indexPath = tableView.indexPathForSelectedRow?.row {
                var DestViewController = segue.destination as! ChooseWorkoutTableViewController
                if indexPath == 0 {
                    DestViewController.currentBodyChoice = "BICEPS"

                } else if indexPath == 1 {
                    DestViewController.currentBodyChoice = "CHESTS"
                } else if indexPath == 2 {
                    DestViewController.currentBodyChoice = "SHOULDERS"
                } else if indexPath == 3 {
                    DestViewController.currentBodyChoice = "Triceps"
                } else if indexPath == 4 {
                    DestViewController.currentBodyChoice = "Calves"
                } else if indexPath == 5 {
                    DestViewController.currentBodyChoice = "Forearms"
                } else if indexPath == 6 {
                    DestViewController.currentBodyChoice = "Glutes"
                } else if indexPath == 7 {
                    DestViewController.currentBodyChoice = "Hamstrings"
                } else if indexPath == 8 {
                    DestViewController.currentBodyChoice = "Lats"
                } else if indexPath == 9 {
                    DestViewController.currentBodyChoice = "lowerback"
                } else if indexPath == 10 {
                    DestViewController.currentBodyChoice = "middleback"
                } else if indexPath == 11 {
                    DestViewController.currentBodyChoice = "quads"
                } else if indexPath == 12 {
                    DestViewController.currentBodyChoice = "traps"
                }
                
            }
        }


        
    }
 

}
