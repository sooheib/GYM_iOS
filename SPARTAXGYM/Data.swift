//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import Foundation
import Firebase

// Firebase Data Services
struct DataServices {
    let ref = FIRDatabase.database().reference()
    var accessToken: String? = nil

}

let data: DataServices = DataServices()
var userID = FIRAuth.auth()?.currentUser?.uid



