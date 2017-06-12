//
//  Constants.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

struct Constants {
    // Place constants here!
    enum DutyStatus : String {
        case complete = "Complete"
        case late = "Late"
        case incomplete = "Incomplete"
        case unassigned = "Unassigned"
    }
    
    enum Roles {
        case hm
        case bouncing
        case checker
        case social
        case admin
    }
}
