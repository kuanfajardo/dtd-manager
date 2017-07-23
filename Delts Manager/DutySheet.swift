//
//  DutySheet.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 7/22/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

struct DutySheet {
    var duties: [DutySheetDuty]
}

class DutySheetDuty {
    
    var days: [Constants.Weekday] = []
    var id: Int?
    var name: String
    
    init(name: String, days: [Constants.Weekday]) {
        self.name = name
        self.days = days
    }
    
    init(name: String, days: [Constants.Weekday], id: Int) {
        self.name = name
        self.days = days
        self.id = id
    }
}
