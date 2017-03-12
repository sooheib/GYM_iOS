//
//  SingUpViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 2/24/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class SingUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstName_Tf         : MKTextField!
    @IBOutlet weak var lastName_tf          : MKTextField!
    @IBOutlet weak var mobile_tf            : MKTextField!
    @IBOutlet weak var email_Tf             : MKTextField!
    @IBOutlet weak var password_Tf          : MKTextField!
    @IBOutlet weak var confirmPassword_Tf   : MKTextField!
    
    @IBOutlet weak var profil_img           : UIImageView!
    
    @IBOutlet weak var signup_btn           : UIButton!

    let picker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  profil_img.layer.masksToBounds = false
        profil_img.layer.cornerRadius = profil_img.frame.size.width/2
        profil_img.clipsToBounds = true
        
        
        
        
        
        
        
        firstName_Tf.addIcon(icon: "name")
        lastName_tf.addIcon(icon: "name")
        email_Tf.addIcon(icon: "msg")
        mobile_tf.addIcon(icon: "phone")
        password_Tf.addIcon(icon: "pwd")
        confirmPassword_Tf.addIcon(icon: "cpwd")

        textField_customization(textField: firstName_Tf)
        textField_customization(textField: lastName_tf)
        textField_customization(textField: email_Tf)
        textField_customization(textField: mobile_tf)
        textField_customization(textField: password_Tf)
        textField_customization(textField: confirmPassword_Tf)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

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
    
    func keyboardWillShow(notification: NSNotification) {
        
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 100
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 100
            }
        }
    }
    
    func complete_signup(){
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
            kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
            kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
            showCloseButton: true
        )

        let alertView = SCLAlertView(appearance : appearance)
        alertView.addButton("Now", target:self, selector: #selector(completeNow))
        alertView.addButton("Later",target:self,  selector: #selector(completeLater))
        alertView.showInfo("", subTitle: "Complete your profile")
    }
    
    @IBAction func signup(_ sender : UIButton){
        if firstName_Tf.text! == "" || lastName_tf.text! == "" || email_Tf.text! == "" || mobile_tf.text! == "" || password_Tf.text! == "" || confirmPassword_Tf.text! == ""{
            
            let alertView = SCLAlertView()
            alertView.showError("", subTitle: "Please fill the fields")
        }
        else if password_Tf.text != confirmPassword_Tf.text{
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "Roboto-Regular", size: 17)!,
                kTextFont: UIFont(name: "Roboto-Regular", size: 17)!,
                kButtonFont: UIFont(name: "Roboto-Regular", size: 17)!,
                showCloseButton: true
            )
            
            
            let alertView = SCLAlertView(appearance : appearance)
            alertView.showError("", subTitle: "Please verify your password")
        }
        else {
            FIRAuth.auth()?.createUser(withEmail: email_Tf.text!, password: password_Tf.text!) { (user, error) in
                if error == nil {
                    print(user!)
                    self.complete_signup()
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
                    alertView.showError("", subTitle: "check your data")
                }
            }
        }
    }
    
    func completeNow(){
        print("now")
        self.performSegue(withIdentifier: "completeprogile_segue", sender: self)
    }
    
    func completeLater(){
        print("later")
        self.performSegue(withIdentifier: "signup_segue", sender: self)
    }
    
    
    
    
    @IBAction func proposePhoto(_ sender:UIButton){
        
        let alertController = UIAlertController(title: "Sélectionner une photo", message: "", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        })
        let  delete = UIAlertAction(title: "Gallerie", style: .default) { (action) -> Void in
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel Button Pressed")
        })
        
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.addAction(delete)
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //let image = PFFile(data: UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.3)!)
        let imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.3)!
        profil_img.image = UIImage.init(data: imageData)!
    }
    
    @IBAction func cancel(_ sender : UIButton!){
        self.dismiss(animated: true, completion: nil)
    }
}
