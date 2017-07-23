//
//  Data.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/18/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import Graph


class Data {
    
    struct UserData {
        static let id = "id"
        static let first = "first"
        static let last = "last"
        static let permissions = "permissions"
        static let email = "email"
        static let username = "username"
        static let year = "year"
        static let isOwner = "isOwner"
    }
    
    struct DutyData {
        static let id = "id"
        static let name = "name"
        static let date = "date"
        static let description = "description"
        static let status = "status"
        static let checkoffTime = "checkoff_time"
    }
    
    struct PuntData {
        static let id = "id"
        static let timestamp = "timestamp"
        static let comment = "comment"
        static let madeup = "madeup"
        static let makeupTime = "makeup_time"
    }
    
    struct PartyDutyData {
        static let id = "id"
        static let start = "start_time"
        static let end = "end_time"
        static let name = "name"
        static let description = "description"
        static let status = "status"
    }
    
    enum DMEntity: String {
        case duty = "Duty"
        case punt = "Punt"
        case partyDuty = "PartyDuty"
        case session = "Session"
        case event = "Event"
        case house = "House"
        case dutySheet = "Duty Sheet"
        case delt = "Delt"
    }

    
    enum DMRelationship: String {
        case event = "Event"
        case owner = "Owner"
        case delt = "Delt"
        case house = "House"
        case dutySheet = "Duty Sheet"
        case houseEvent = "House Event"
    }

    
    static func createGraphWithOwner(_ owner: DMUser, completion: @escaping (Bool, Error?) -> Void) -> Void{
        let graph = Graph()
        graph.clear()
        
        let ownerEntity = Entity(type: .delt)
        ownerEntity[UserData.isOwner] = true;
        
        ownerEntity[UserData.username] = owner.username
        ownerEntity[UserData.id] = owner.id
        ownerEntity[UserData.email] = owner.email
        ownerEntity[UserData.first] = owner.firstName
        ownerEntity[UserData.last] = owner.lastName
        ownerEntity[UserData.permissions] = owner.permissions
        ownerEntity[UserData.year] = owner.year
        
        
        // DUTIES //
        let duties = Session.session.loadDuties()
        
        duties.forEach { (duty) in
            let dutyEntity = Entity(type: .duty)
            dutyEntity.is(relationship: .event).in(object: ownerEntity)
        }
        
        
        // PUNTS //
        let punts = Session.session.loadPunts()
        
        punts.forEach { (punt) in
            let puntEntity = Entity(type: .punt)
            puntEntity.is(relationship: .event).in(object: ownerEntity)
            
            // TODO: Make Punt Object from Entity; store in Session
        }
        
        
        // PARTY DUTIES //
        let partyDuties: [PartyDuty] = [] // Session.session.loadPartyDuties()
        
        partyDuties.forEach { (partyDuty) in
            let partyDutyEntity = Entity(type: .partyDuty)
            partyDutyEntity.is(relationship: .event).in(object: ownerEntity)
            
            // TODO: Make Party Duty Object from Entity; store in Session
        }
        
        
        // EVENTS //
        let events: [Event] = [] // Session.session.loadEvents()
        
        events.forEach { (event) in
            let eventEntity = Entity(type: .event)
            eventEntity.is(relationship: .event).in(object: ownerEntity)
            
            // TODO: Make Event Object from Entity; store in Session
        }
        
        
        let houseEntity = Entity(type: .house)

        
        // DUTY SHEET //
        let dutySheet = Session.session.loadDutySheet()
        
        let dutySheetEntity = Entity(type: .dutySheet)
        dutySheetEntity.is(relationship: .dutySheet).in(object: houseEntity)
        // TODO: Make DutySheet Object from Entity; store in Session
        
        dutySheet.duties.forEach { (duty) in
            let dutyEntity = Entity(type: .duty)
            dutyEntity.is(relationship: .event).in(object: dutySheetEntity)
            
            // TODO: Make DutySheetDuty Object from Entity; store in Session
        }
        
        
        let graphSession = Entity(type: .session)

        ownerEntity.is(relationship: .owner).in(object: graphSession)
        houseEntity.is(relationship: .house).in(object: graphSession)

        graph.sync(completion)
    }
}
