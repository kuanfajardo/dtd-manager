//
//  Constants.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Constants {
    // Place constants here!
    enum DutyStatus : String {
        case complete = "Complete"
        case late = "Late"
        case incomplete = "Incomplete"
        case checkoffRequested = "Requesting Checkoff"
        case pickedUp = "Picked Up"
        case unassigned = "Unassigned"
    }
    enum Roles {
        case hm
        case bouncing
        case checker
        case social
        case admin
    }
    
    enum PartyDutyStatus : String {
        case complete = "Complete"
        case punted = "Incomplete"
        case unchecked = "Unchecked"
        case unassigned = "Unassigned"
    }
    
    static var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    static var db: DatabaseReference {
        return Database.database().reference()
    }
    
    
    struct Identifiers {
        
        struct Controllers {
            static let TabBarController = "tabbarcontroller"
        }
        
        struct TableViewCells {
            static let DMCardCell = "DMCell"
        }
    }
    
    struct Notifications {
        static let DMDutiesUpdatedNotification = NSNotification.Name(rawValue: "UpdateDuties")
        static let DMPuntsUpdatedNotification = NSNotification.Name(rawValue: "UpdatePunts")
        static let DMDutySheetAvailableNotification = NSNotification.Name(rawValue: "DutySheetAvailable")
        static let DMDutySheetClosedNotification = NSNotification.Name(rawValue: "DutySheetClosed")
    }
    
    enum PuntTypes {
        case duty
        case social
        case bouncing
        case admin
        case guide
    }
    
    enum DutyUpdateTypes {
        case new
        case edit
        case delete
    }
    
    enum Weekday: Int {
        case sunday = 0
        case monday = 1
        case tuesday = 2
        case wednesday = 3
        case thursday = 4
        case friday = 5
        case saturday = 6
    }
}
