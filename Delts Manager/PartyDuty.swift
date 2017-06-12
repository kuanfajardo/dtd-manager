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
    var user : User
    var giver : User
    var completed : Bool
    
    // Initialization
    init(giver : User, startTime : NSDate, endTime : NSDate, user : User, name : String, desc : String) {
        
        self.giver = giver
        
        self.startTime = startTime
        self.endTime = endTime
        
        self.name = name
        self.desc = desc
        
        self.user = user
        self.completed = false
    }
    
    func checkOff() -> Void {
        self.completed = true
    }
    
    func punt() -> Void {
        self.completed = false
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
    
    func getUser() -> User {
        return self.user
    }
    
    func isCompleted() -> Bool {
        return self.completed
    }

}
