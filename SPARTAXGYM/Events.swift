//
//  Events.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/22/17.
//  Copyright © 2017 souheib. All rights reserved.
//


class Events {

    var event_name: String?
    var event_desc: String?
    var event_cover: String?
    
    init(nameevent: String?, descevent: String?, coverevent: String?){
        self.event_name = nameevent
        self.event_desc = descevent
        self.event_cover = coverevent
    }
    
    
    init(nameevent: String?,coverevent: String?){
        self.event_name = nameevent
        self.event_cover = coverevent
    }
    
    init(nameevent: String?){
        self.event_name = nameevent
        
    }

}
