//
//  ViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 2/23/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                print(accessToken)
                print(declinedPermissions)
                print(grantedPermissions)
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    // ...
                    if error == nil {
                        print(error!)
                    }
                    else{
                        print("success")
                        self.performSegue(withIdentifier: "social_login", sender: self)
                    }
                }
            }
        }
    }

    
    
    }

