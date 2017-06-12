//
//  Duty.swift
//  Delts Manager
//
//  Created by Andre Curiel on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

class Duty {
    // Instance variables
    let dutyName : String
    let date : NSDate
    let description : String
    let status : DutyStatus
    let assignee : User
    let checkOffTime : NSDate
    let checker : User 
    
    // Initialization
    init(dutyName: String, date: NSDate, description: String, status: String, assignee: User, checkOffTime: NSDate, checker: User) {
        self.dutyName = dutyName
        self.date = date
        self.description = description
        self.status = status
        self.assignee = assignee
        self.checkOffTime = checkOffTime
        self.checker = checker
    }

}
