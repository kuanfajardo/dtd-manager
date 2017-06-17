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
    private let DUTIES_NODE = Constants.db.child("houseduties")
    
    // Properties
    var user: User? // user currently logged in
    var isDutySheetAvailable = false
    
    static let session = Session() // singleton object
    
    
    //---------------------------------------------+
    //             MARK: Initialization            |
    //---------------------------------------------+
    
    // Private to prevent more than one instance of Session
    private init() {
        //
    }
    
    // "Init" method; must be first method called when using a Session object
    func initWithUser(_ user: User) {
        self.user = user
        
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
        let userDutiesNode = Constants.db.child("users").child((self.user?.username)!).child("duties")
        
        userDutiesNode.observe(.value, with: { (snapshot) in
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
        let userPuntsNode = Constants.db.child("users").child((self.user?.username)!).child("punts")
        
        userPuntsNode.observe(.value, with: { (snapshot) in
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
        let dutySheetNode = Constants.db.child("duty_sheet").child("is_available")
        
        dutySheetNode.observe(.value, with: { (snapshot : DataSnapshot) in
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
            let user = User(username: username, json: json)
            
            Session.session.initWithUser(user)
            completion(nil)
        }
    }
    
    
    
    
    //--------------------------------------------+
    //                MARK: API                   |
    //--------------------------------------------+
    
    
    //--------------------+
    //        User        |
    //--------------------+
    
    // GET
    
    func loadDuties() -> [Duty] {
        return []
    }
    
    func loadPunts() -> [Punt] {
        return []
    }
    
    func loadDutySheet() -> Void { // TODO: DutySheet type
        
    }
    
    func loadParties() -> Void { // TODO: Party type
        
    }
    
    func loadInviteList(forParty party: Int) {
        
    }
    
    
    // POST
    
    func requestCheckoff(forDuty duty: Duty) -> Void { // TODO: bools for post return?
        
    }
    
    func claimDuty(_ duty: Duty, callback: (_ success: Bool) -> Void) -> Void {
        
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
    
    func punt(user: User, for type: Constants.PuntTypes, options: [String : Any]?) -> Void {
        
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
    
    func loadAllUsers() -> [User] {
        return []
    }
    
    
    // POST
    
    func updateDuty(_ duty: Duty, options: [String : Any]) {
        
    }
    
    func updatePunt(_ punt: Punt, options: [String : Any]) {
        
    }
    
    
}
