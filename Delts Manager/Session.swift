//
//  Session.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/17/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import SwiftyJSON
import Firebase


class Session {
    // Constants
    private let ALL_USERS = Constants.db.child("users")
    private let DUTIES_NODE = Constants.db.child("houseduties")
    private let DUTYSHEET_NODE = Constants.db.child("housedutieslkp").child("is_duty_sheet_available")
    private var USER_DUTIES: DatabaseReference? {
        guard let username = self.owner?.username else {
            return nil
        }
        
        return Constants.db.child("users/\(username)/duties")
    }
    
    private var USER_PUNTS: DatabaseReference? {
        guard let username = self.owner?.username else {
            return nil
        }
        
        return Constants.db.child("users/\(username)/punts")
    }
    
    private var USER_EVENTS: DatabaseReference? {
        guard let username = self.owner?.username else {
            return nil
        }
        
        return Constants.db.child("users/\(username)/events")
    }

    
    
    // Properties
    var owner: DMUser? // user currently logged in
    var isDutySheetAvailable = false
    var allUsers: [DMUser]?
    var currentDutySheet: DutySheet? {
        return self.loadDutySheet()
    }
    
    static var owner: DMUser? {
        return Session.session.owner
    }
    
    static let session = Session() // singleton object
    
    
    //---------------------------------------------+
    //             MARK: Initialization            |
    //---------------------------------------------+
    
    // Private to prevent more than one instance of Session
    private init() {}
    
    // "Init" method; must be first method called when using a Session object
    func initWithUser(_ user: DMUser) {
        self.owner = user
        
        setUpObservers()
    }
    
    
    func setUpObservers() -> Void {
        startDutiesObserver()
        startPuntsObserver()
        startDutySheetAvailabilityObserver()
        startDutySheetObserver()
    }
    
    
    // Listener for Duties
    private func startDutiesObserver() -> Void {
        USER_DUTIES!.observe(.value, with: { (snapshot) in
            // Get new updated list of duties
            let updatedDuties = snapshot.json.arrayObject as? [String] ?? []
            let userInfo = ["payload" : updatedDuties]
            
            // Post notification with new duties
            let dutiesNotification = Notification(name: Constants.Notifications.DMDutiesUpdatedNotification, object: nil, userInfo: userInfo)
            
            NotificationCenter.default.post(dutiesNotification)
        })
    }
    
    // Listener for Punts
    private func startPuntsObserver() -> Void {
        USER_PUNTS!.observe(.value, with: { (snapshot) in
            // Get new updated list of punts
            let updatedPunts = snapshot.json.arrayObject as? [String] ?? []
            let userInfo = ["payload" : updatedPunts]
            
            // Post notification with new punts
            let puntsNotification = Notification(name: Constants.Notifications.DMPuntsUpdatedNotification, object: nil, userInfo: userInfo)
            
            NotificationCenter.default.post(puntsNotification)
        })
    }
    
    // Listener for Duty Sheet Availability
    private func startDutySheetAvailabilityObserver() -> Void {
        DUTYSHEET_NODE.observe(.value, with: { (snapshot : DataSnapshot) in
            // Get new availability of duty sheet
            self.isDutySheetAvailable = snapshot.json.bool!
            
            // Post corresponding notification
            let notificationName = self.isDutySheetAvailable ?
                Constants.Notifications.DMDutySheetAvailableNotification :
                Constants.Notifications.DMDutySheetClosedNotification
            
            let notification = Notification(name: notificationName, object: nil, userInfo: nil)
            
            NotificationCenter.default.post(notification)
        })
    }
    
    // Listener for Duty Sheet updates (i.e. claiming duties)
    private func startDutySheetObserver() -> Void {
        let dutySheetNode = Constants.db.child("duty_sheet")
        
        dutySheetNode.observe(.value) { (snapshot : DataSnapshot) in
            // TODO:
            
        }
    }
    
    // Get whether user of session is authorized for a given role
    func isAuthorized(forRole role: Constants.Roles) -> Bool {
        return false;
    }
    
    
    //--------------------------------------------+
    //           MARK: Authentication             |
    //--------------------------------------------+
    
    
    static func signIn(withEmail email: String, password: String, completion: @escaping (_ error: Error?) -> Void) -> Void {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (error == nil) {
                print("login yay!")
                let endIndex = email.characters.index(of: "@")!
                let username = String(email.characters.prefix(upTo: endIndex))
 
                Session.completeLogin(username, completion: completion)
                
            } else {
                completion(error)
            }
        }
    }
    
    static func completeLogin(_ username: String, completion: @escaping (_ error: Error?) -> Void) -> Void {
        Constants.db.child("users").child(username).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            let json = snapshot.json
            let user = DMUser(username: username, json: json)
            
            Session.session.initWithUser(user)
            
            Data.createGraphWithOwner(user) { (success: Bool, error: Error?) in
                if error != nil {
                    completion(nil)
                } else {
                    completion(error)
                }
            }
        }
    }
    
    
    ////
    
    var dutyNames: [String : String] = [:]
    var deltDict: [String : String] = [:]
    
    func dutyNameForID(_ id: String) -> String {
        return dutyNames[id]!
    }
    
    func deltForUsername(_ username: String) -> String {
        return deltDict[username]!
    }
    
    
    ////
    
    
    //--------------------------------------------+
    //                MARK: API                   |
    //--------------------------------------------+
    
    
    //--------------------+
    //        User        |
    //--------------------+
    
    // GET
    
    func loadDuties() -> [Duty] {
        var duties: [Duty] = []
        
        USER_DUTIES!.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            let json = snapshot.json
            let duty_ids = json.arrayObject as! [Int]

            duty_ids.forEach({ (id) in
                
                let dutyNode = self.DUTIES_NODE.child("\(id)")
                    
                dutyNode.observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
                    let json = snapshot.json
                    let duty = Duty(json: json, id: id)
                    
                    duties.append(duty)
                })
            })
        }
        
        return duties
    }
    
    func loadPunts() -> [Punt] {
        return []
    }
    
    func loadDutySheet() -> DutySheet {
        return DutySheet(duties: [.init(name: "Basement", days: [.sunday])])
    }
    
    func loadParties() -> Void { // TODO: Party type
        
    }
    
    func loadInviteList(forParty party: Int) {
        
    }

    
    
    // POST
    
    func requestCheckoff(forDuty duty: Duty) -> Void { // TODO: bools for post return?
        
    }
    
    func claimDuty(_ duty: Duty, callback: (_ success: Bool) -> Void) -> Void {
        USER_DUTIES?.setValue(2, withCompletionBlock: { (error: Error?, ref: DatabaseReference) in
            if (error == nil) {
                // SUCCESS
            } else {
                // SHOW USER DUTY ALREADY TAKEN
            }
        })
    }
    
    func disclaimDuty(_ duty: Duty, callback: (_ success: Bool) -> Void) -> Void {
        
    }
    
    func addInvite(_ invite: String, toParty party: String) { // TODO: Invite, Party types
        
    }
    
    func updateParty(_ party: String, options: [String : Any]?) { // TODO: Party type
        
    }
    
    
    //---------------------+
    //       Checker       |
    //---------------------+
    
    // GET
    
    func loadCheckoffRequests() -> [Duty] {
        return []
    }
    
    
    // POST
    
    func checkoffDuty(_ duty: Duty) -> Void {
        
    }
    
    func removeRequestForDuty(_ duty: Duty) -> Void {
        
    }
    
    
    //-------------------------+
    //      House Manager      |
    //-------------------------+
    
    // POST
    
    func punt(user: DMUser, for type: Constants.PuntTypes, options: [String : Any]?) -> Void {
        
    }
    
    
    //-------------------------+
    //       Social Chair      |
    //-------------------------+
    
    // POST
    
    // ?? have ocnvenience func or just use update party??
    func addParty(_ party: String) { // TODO: Party type
        
    }
    
    func updateParty(_ party: String) { // TODO: Party type
        
    }
    
    
    //---------------------------+
    //       Bouncing Chair      |
    //---------------------------+
    
    // POST
    
    func updatePartyDuty(_ duty: PartyDuty, options: [String : Any]) {
        
    }
    
    
    //---------------------+
    //        Admin        |
    //---------------------+
    
    // GET
    
    func loadAllDuties() -> [Duty] {
        return []
    }
    
    func loadAllPunts() -> [Punt] {
        return []
    }
    
    func loadAllUsers() -> [DMUser] {
        return []
    }
    
    
    // POST
    
    func updateDuty(_ duty: Duty, options: [String : Any]) {
        
    }
    
    func updatePunt(_ punt: Punt, options: [String : Any]) {
        
    }
    
    
}
