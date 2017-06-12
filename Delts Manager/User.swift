//
//  User.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

class User {
    // Instance variables
    let firstName : String
    let lastName : String
    var year : Int
    let email : String
    var duties : [String] // TODO: replace with [Duty]
    var punts : [String] // TODO: replace with [Punt]
    var partyDuties: [String] // TODO: replace with [PartyDuty]
    var permissions: Set<Constants.Roles>
    
    // Initialization
    init(firstName: String, lastName: String, year: Int, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.year = year
        self.email = email
        
        self.duties = []
        self.punts = []
        self.partyDuties = []
        self.permissions = []
    }
}
