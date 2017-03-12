//
//  MyNavigationController.swift
//  SPARTAXGYM
//
//  Created by souheib on 2/24/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

typealias BarLookForVC = (VCType:AnyClass, hidden:Bool?, color:UIColor? , tintColor:UIColor?, title: String?)

class MyNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate  {

    let  barlookForVCs:[BarLookForVC]? =
        [ (HomeViewController.self, false, UIColor.init(red: 82/255, green: 82/255, blue: 79/255, alpha: 1), UIColor.white, "Home!"),
             (ClassesViewController.self, false, UIColor.init(red: 82/255, green: 82/255, blue: 79/255, alpha: 1), UIColor.white, "Classes!"),
             (DemoViewController.self, false, UIColor.init(red: 82/255, green: 82/255, blue: 79/255, alpha: 1), UIColor.white, "Events!"),
                (TrainersViewController.self, false, UIColor.init(red: 82/255, green: 82/255, blue: 79/255, alpha: 1), UIColor.white, "Trainers!")

            
          ]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self;
        self.navigationBar.isTranslucent = false

        self.interactivePopGestureRecognizer?.isEnabled = false
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let barLook = self.barlookForVCs?.filter({ (barlook:BarLookForVC) -> Bool in
            return (NSStringFromClass(type(of: viewController)) == NSStringFromClass(barlook.VCType))
            
        }).first
        {
            self.setNavigationBarHidden(barLook.hidden ?? self.isNavigationBarHidden, animated: true)
            self.navigationBar.barTintColor = barLook.color ?? self.navigationBar.barTintColor
            self.navigationBar.tintColor = barLook.tintColor ?? self.navigationBar.tintColor
            if let title = barLook.title {

                let textAttributes = [
                    NSForegroundColorAttributeName: UIColor.white,
                    NSStrokeColorAttributeName: UIColor.black,
                    NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 22)!,
                    NSStrokeWidthAttributeName: 1.0
                ] as [String : Any]
                
                
                viewController.navigationController?.navigationBar.titleTextAttributes = textAttributes
                viewController.navigationItem.title = title

            }
            
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        }
        
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //    print("didShow, \(viewController.title)");
        
    }

}
