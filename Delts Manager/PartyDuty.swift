//
//  PartyDuty.swift
//  Delts Manager
//
//  Created by Tim Henry on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

class PartyDuty: Event {
    // Instance variables
    var startTime : Date?
    var endTime : Date?
    var user : DMUser?
    var giver : DMUser?
    var status : Constants.PartyDutyStatus?
    
    // Initialization
    init(giver : DMUser, startTime : Date, endTime : Date, name : String, desc : String, id: Int) {
        super.init(id: id, title: name)
        
        self.description = desc
        
        self.giver = giver
        self.startTime = startTime
        self.endTime = endTime
        self.status = .unassigned
    }
    
    init(id: Int) {
        super.init(id: id, title: "Party Duty")
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
