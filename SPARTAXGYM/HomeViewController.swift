//
//  HomeViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 2/24/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                
            } else {
//                self.performSegue(withIdentifier: "goToLogin", sender: self)
            }
        }
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        
}
    
    override func viewWillAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            getTodaysWorkouts()
        }    }
}
