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
    let id: Int
    
    var date: Date?
    var duty: Duty?
    var comment: String?
    var user: User?
    var giver: User?
    var madeUp: Bool?
    
    // Initialization
    init(giver: User, user: User, duty: Duty, comment: String, id: Int) {
        
        self.date = Date.init()
            
        self.giver = giver
        self.user = user
        self.duty = duty
        self.comment = comment
        
        self.madeUp = false
        
        self.id = id
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func makeUp() -> Void {
        self.madeUp = true
    }
    
    func getDate() -> Date {
        return self.date!
    }
    
    func getDuty() -> Duty {
        return self.duty!
    }
    
    func getComment() -> String {
        return self.comment!
    }
    
    func getUser() -> User {
        return self.user!
    }
    
    func getGiver() -> User {
        return self.giver!
    }
    
    func isMadeUp() -> Bool {
        return self.madeUp!
    }
}
