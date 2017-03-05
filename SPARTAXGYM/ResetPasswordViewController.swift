//
//  ResetPasswordViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 2/24/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class ResetPasswordViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var email_Tf  : MKTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email_Tf.addIcon(icon: "msg")
        
        textField_customization(textField: email_Tf)
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
    
    @IBAction func reset_password (_ sender : UIButton){
        if email_Tf.text! == ""{
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
                kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
                kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
                showCloseButton: true
            )
            
            let alertView = SCLAlertView(appearance : appearance)
            alertView.showError("", subTitle: "Please fill the field")
        }
        else {
            FIRAuth.auth()?.sendPasswordReset(withEmail: email_Tf.text!) { error in
                if error == nil {
                    let appearance = SCLAlertView.SCLAppearance(
                        kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        showCloseButton: false
                    )
                    
                    
                    let alertView = SCLAlertView(appearance : appearance)
                    alertView.showInfo("", subTitle: "An E-mail was send to your mail address")
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    print(error!)
                    let appearance = SCLAlertView.SCLAppearance(
                        kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
                        showCloseButton: true
                    )
                    
                    
                    let alertView = SCLAlertView(appearance : appearance)
                    alertView.showError("", subTitle: "Please fill the field")
                }
            }
        }
        
    }

    
    @IBAction func cancel(_ sender : UIButton!){
        self.dismiss(animated: true, completion: nil)
    }
    
}
