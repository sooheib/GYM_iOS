//
//  LoginViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 2/24/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var email_Tf  : MKTextField!
    @IBOutlet weak var password_Tf : MKTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email_Tf.addIcon(icon: "msg")
        password_Tf.addIcon(icon: "pwd")
        
        textField_customization(textField: email_Tf)
        textField_customization(textField: password_Tf)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField_customization(textField : UITextField){
        textField.layer.borderWidth = 0
        textField.returnKeyType = .done
        textField.delegate = self
    }
    
    @IBAction func login (_ sender : UIButton){
        if email_Tf.text! == "" || password_Tf.text! == ""{
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
                kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
                kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
                showCloseButton: true
            )
    
            
            let alertView = SCLAlertView(appearance : appearance)
            alertView.showError("", subTitle: "Please fill the fields")
        }
        else {
            
            let ref : FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            
            FIRAuth.auth()?.signIn(withEmail: email_Tf.text!, password: password_Tf.text!, completion: {
                user, error in
                
                if error != nil {
          
                    print(error!)
                    
                    let appearance = SCLAlertView.SCLAppearance(
                        kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        showCloseButton: true
                    )
                    
                    
                    let alertView = SCLAlertView(appearance : appearance)
                    alertView.showError("", subTitle: "Please check you email and password")
                    
                    
                } else {
                    let userID = FIRAuth.auth()?.currentUser?.uid
                    ref.child("users").child(userID!).child("userInfo").observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let value = snapshot.value as? NSDictionary
                        let workoutPlanned = value!["workoutPlanned"] as! String
                        if workoutPlanned == "no" {
                            self.performSegue(withIdentifier: "login_segue", sender: self)
                        } else {
                            self.performSegue(withIdentifier: "login_segue", sender: self)
                        }
                        // ...
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    
                    
                    
                }
                
                
            })
            
            
            
            
            
//            
//            
//            
//            
//            
//            
//            FIRAuth.auth()?.signIn(withEmail: email_Tf.text!, password: password_Tf.text!) { (user, error) in
//                if error == nil {
//                    print(user!)
//                    
//                    self.performSegue(withIdentifier: "login_segue", sender: self)
//                }
//                else{
//                    print(error!)
//                    
//                    let appearance = SCLAlertView.SCLAppearance(
//                        kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
//                        kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
//                        kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
//                        showCloseButton: true
//                    )
//                    
//                    
//                    let alertView = SCLAlertView(appearance : appearance)
//                    alertView.showError("", subTitle: "Please check you email and password")
//                }
//            }
        }

    }

    @IBAction func cancel(_ sender : UIButton!){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MKTextField{
    func addIcon(icon : String){
        let imageView = UIImageView()
        let image = UIImage(named: icon)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 40, width: 20, height: 20)
        self.leftView = imageView
        self.leftViewMode = UITextFieldViewMode.always
    }

    func addRightView(icon : String){
        let imageView = UIImageView()
        let image = UIImage(named: icon)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 40, width: 20, height: 20)
        self.rightView = imageView
        self.rightViewMode = UITextFieldViewMode.always
    }
}
