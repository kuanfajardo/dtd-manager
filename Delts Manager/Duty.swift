//
//  Duty.swift
//  Delts Manager
//
//  Created by Andre Curiel on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import SwiftyJSON

class Duty {
    // Instance variables
    let id: Int
    
    var dutyName: String?
    var date: Date?
    var description: String?
    var status: Constants.DutyStatus?
    var assignee: DMUser?
    var checkOffTime: Date?
    var checker: DMUser?
    
    // Initialization
    init(dutyName: String, date: Date, description: String, status: Constants.DutyStatus, assignee: DMUser, checkOffTime: Date?, checker: DMUser, id: Int) {
        self.dutyName = dutyName
        self.date = date
        self.description = description
        self.status = status
        self.assignee = assignee
        self.checkOffTime = checkOffTime
        self.checker = checker
        self.id = id
    }
    
    init(id: Int) {
        self.id = id
    }

}

extension Duty: Equatable {
    static func == (lhs: Duty, rhs: Duty) -> Bool {
        return lhs.id == rhs.id
    }
}
