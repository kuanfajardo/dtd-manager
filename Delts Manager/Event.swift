//
//  Event.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/22/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

class Event {
    // Instance variables
    let id: Int
    let title: String
    
    var date: Date?
    var description: String?
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
