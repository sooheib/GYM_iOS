//
//  CompleteProfileViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 2/24/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class CompleteProfileViewController: UIViewController {
    
 
    @IBOutlet weak var age: MKTextField!
    @IBOutlet weak var height: MKTextField!
    @IBOutlet weak var weight: MKTextField!
    @IBOutlet weak var goal: MKTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        age.layer.borderWidth = 0
        height.layer.borderWidth = 0
        weight.layer.borderWidth = 0
        goal.layer.borderWidth = 0
        
        age.addIcon(icon: "age")
        height.addIcon(icon: "height")
        weight.addIcon(icon: "weight")
        goal.addIcon(icon: "goal")

        
//        textField_customization(textField: age)
//        textField_customization(textField: height)
//        textField_customization(textField: weight)
//        textField_customization(textField: goal)


    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender : UIButton!){
        self.dismiss(animated: true, completion: nil)
    }
      /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   

    
    
}
