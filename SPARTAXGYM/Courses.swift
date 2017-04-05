//
//  Courses.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/21/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class Courses {

    var course_name: String?
    var course_desc: String?
    var course_cover: String?
    
    init(namecourse: String?, desccourse: String?, covercourse: String?){
        self.course_name = namecourse
        self.course_desc = desccourse
        self.course_cover = covercourse
    }
    
    
    init(namecourse: String?,covercourse: String?){
        self.course_name = namecourse
        self.course_cover = covercourse
    }
    
    init(namecourse: String?){
        self.course_name = namecourse
        
    }


}
