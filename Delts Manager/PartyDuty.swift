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
    let id: Int
    
    var startTime : Date?
    var endTime : Date?
    var name : String?
    var desc : String?
    var user : DMUser?
    var giver : DMUser?
    var status : Constants.PartyDutyStatus?
    
    // Initialization
    init(giver : DMUser, startTime : Date, endTime : Date, name : String, desc : String, id: Int) {
        
        self.giver = giver
        
        self.startTime = startTime
        self.endTime = endTime
        
        self.name = name
        self.desc = desc
        
        self.status = .unassigned
        
        self.id = id
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func checkOff() -> Void {
        self.status = .complete
    }
    
    func punt() -> Void {
        self.status = .punted
        // TODO actually create punt
    }
    
    func getStartTime() -> Date {
        return self.startTime!
    }
    
    func getEndTime() -> Date {
        return self.startTime!
    }
    
    func getName() -> String {
        return self.name!
    }
    
    func getDesc() -> String {
        return self.desc!
    }
    
    func getGiver() -> DMUser {
        return self.giver!
    }
    
    func getUser() -> DMUser? {
        return self.user!
    }
    
    func getStatus() -> Constants.PartyDutyStatus {
        return self.status!
    }

}
