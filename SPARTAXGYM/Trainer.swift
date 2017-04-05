//
//  Trainer.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/22/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class Trainer{

    
    var trainer_name: String?
    var trainer_desc: String?
    var trainer_cover: String?
    
    init(nametrainer: String?, desctrainer: String?, covertrainer: String?){
        self.trainer_name = nametrainer
        self.trainer_desc = desctrainer
        self.trainer_cover = covertrainer
    }
    
    
    init(nametrainer: String?,covertrainer: String?){
        self.trainer_name = nametrainer
        self.trainer_cover = covertrainer
    }
    
    init(nametrainer: String?){
        self.trainer_name = nametrainer
        
    }

}
