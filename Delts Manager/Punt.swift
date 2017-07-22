//
//  Punt.swift
//  Delts Manager
//
//  Created by Tim Henry on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import Material

class Punt: Event {
    // Instance variables
    var duty: Duty?
    var comment: String?
    var user: DMUser?
    var giver: DMUser?
    var madeUp: Bool?
    var makeupTime: Date?
    
    // Initialization
    init(giver: DMUser, user: DMUser, duty: Duty, comment: String, id: Int) {
        super.init(id: id, title: "Punt")
            
        self.date = Date.init()
            
        self.giver = giver
        self.user = user
        self.duty = duty
        self.comment = comment
        
        self.madeUp = false
    }
    
    init(id: Int) {
        super.init(id: id, title: "Punt")
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
    
    func getUser() -> DMUser {
        return self.user!
    }
    
    func getGiver() -> DMUser {
        return self.giver!
    }
    
    func isMadeUp() -> Bool {
        return self.madeUp!
    }
}


extension Punt: DMCardDataSource {
    func titleForCard(_ card: DMCard) -> String {
        return "Punt!"
    }
    
    func detailForCard(_ card: DMCard) -> String {
        return "Given by \(self.giver!.fullName)"
    }
    
    func buttonImageForCard(_ card: DMCard) -> UIImage? {
        return Icon.work
    }
    
    func contentForCard(_ card: DMCard) -> String {
        return self.comment!
    }
}
