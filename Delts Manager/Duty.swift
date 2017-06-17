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
    let date : Date
    let description : String
    let status : Constants.DutyStatus
    let assignee : User
    let checkOffTime : Date
    let checker : User
    
    // Initialization
    init(dutyName: String, date: Date, description: String, status: String, assignee: User, checkOffTime: Date, checker: User) {
        self.dutyName = dutyName
        self.date = date
        self.description = description
        self.status = .incomplete
        self.assignee = assignee
        self.checkOffTime = checkOffTime
        self.checker = checker
    }

}
