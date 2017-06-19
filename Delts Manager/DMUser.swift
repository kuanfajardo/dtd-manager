//
//  DMUser.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import EZSwiftExtensions
import SwiftyJSON

class DMUser {
    // Instance variables
    let id: String
    let firstName: String
    let lastName: String
    
    var fullName: String {
        return firstName + " " + lastName
    }
    
    public private(set) var year: Int?
    public private(set) var email: String?
    public private(set) var username: String?
        
    var duties: [Duty] = []
    var punts: [Punt] = []
    var partyDuties: [PartyDuty] = []
    var permissions: Set<Constants.Roles> = []
    
    
    // Initialization
    init(username: String, json: JSON) {
        self.username = username

        self.id = json["id"].stringValue
        self.firstName = json["first"].stringValue
        self.lastName = json["last"].stringValue
        self.year = json["year"].intValue
        self.email = json["email"].stringValue
        
        registerToObserveNotifications()
    }
    

    // Setters
    func addDuty(_ duty: Duty) {
        self.duties.append(duty)
    }
    

    @objc
    func updateDuties() -> Void {
        print("Duties Updated")
    }
    
    @objc
    func updatePunts() -> Void {
        print("Punts Updated")
    }
    
    
    func registerToObserveNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(updateDuties), name: Constants.Notifications.DMDutiesUpdatedNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePunts), name: Constants.Notifications.DMPuntsUpdatedNotification, object: nil)
    }
}
