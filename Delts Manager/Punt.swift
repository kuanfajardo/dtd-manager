//
//  Punt.swift
//  Delts Manager
//
//  Created by Tim Henry on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation

class Punt {
    // Instance variables
    var date : NSDate
    var duty : Duty
    let comment : String
    var user : User
    var giver : User
    var madeUp : Bool
    
    // Initialization
    init(giver : User, user : User, duty : Duty, comment : String) {
        
        self.date = NSDate.init()
            
        self.giver = giver
        self.user = user
        self.duty = duty
        self.comment = comment
        
        self.madeUp = false
    }
    
    func makeUp() -> Void {
        self.madeUp = true
    }
    
    func getDate() -> NSDate {
        return self.date
    }
    
    func getDuty() -> Duty {
        return self.duty
    }
    
    func getComment() -> String {
        return self.comment
    }
    
    func getUser() -> User {
        return self.user
    }
    
    func getGiver() -> User {
        return self.giver
    }
    
    func isMadeUp() -> Bool {
        return self.madeUp
    }
}
