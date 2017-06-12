//
//  PartyDuty.swift
//  Delts Manager
//
//  Created by Tim Henry on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

class PartyDuty {
    // Instance variables
    var startTime : NSDate
    var endTime : NSDate
    let name : String
    let desc : String
    var user : User?
    var giver : User
    var status : Constants.PartyDutyStatus
    
    // Initialization
    init(giver : User, startTime : NSDate, endTime : NSDate, name : String, desc : String) {
        
        self.giver = giver
        
        self.startTime = startTime
        self.endTime = endTime
        
        self.name = name
        self.desc = desc
        
        self.status = .unassigned
    }
    
    func checkOff() -> Void {
        self.status = .complete
    }
    
    func punt() -> Void {
        self.status = .punted
        // TODO actually create punt
    }
    
    func getStartTime() -> NSDate {
        return self.startTime
    }
    
    func getEndTime() -> NSDate {
        return self.startTime
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getDesc() -> String {
        return self.desc
    }
    
    func getGiver() -> User {
        return self.giver
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func getStatus() -> Constants.PartyDutyStatus {
        return self.status
    }

}
