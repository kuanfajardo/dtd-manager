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
        case user = "User"
        case duty = "Duty"
        case punt = "Punt"
        case partyDuty = "PartyDuty"
        case session = "Session"
    }
    
    // (M) : "to many"; (1) : "to one"
    struct DMRelationships {
        static let hasDuty = "has_duty"               // User -> Duty (M)
        static let hasPunt = "has_punt"               // User -> Punt (M)
        static let hasPartyDuty = "has_party_duty"    // User -> PartyDuty (M)
        
        static let assignedTo = "assigned_to_duty"    // PartyDuty -> User (1), Duty -> User (1)
        static let givenTo = "given_to"               // Punt -> User (1)
        static let givenBy = "given_by"               // Punt -> User (1)
        static let checker = "checker"                // Duty -> User (1)
        
        static let owner = "owner"                    // Session -> User (1)
        static let isOwnerOf = "is_owner"             // User -> Session (1)
        
        static let hasUser = "has_user"               // Session -> User (M)
        static let belongsTo = "belongs_to"           // User -> Session (1)
    }
    
    static func createGraphWithOwner(_ owner: DMUser, completion: @escaping (Bool, Error?) -> Void) -> Void{
        let graph = Graph()
        graph.clear()
        
        let ownerEntity = Entity(type: .user)
        ownerEntity[UserData.username] = owner.username
        
        ownerEntity[UserData.id] = owner.id
        ownerEntity[UserData.email] = owner.email
        ownerEntity[UserData.first] = owner.firstName
        ownerEntity[UserData.last] = owner.lastName
        ownerEntity[UserData.permissions] = owner.permissions
        ownerEntity[UserData.year] = owner.year
        
        let graphSession = Entity(type: .session)
        ownerEntity.is(relationship: DMRelationships.isOwnerOf).in(object: graphSession)
        graphSession.is(relationship: DMRelationships.owner).in(object: ownerEntity) // inverse of above; TODO: needed?
        
        ownerEntity.is(relationship: DMRelationships.belongsTo).in(object: graphSession)
        graphSession.is(relationship: DMRelationships.hasUser).in(object: ownerEntity) // inverse of above; TODO: needed?
        
        graph.sync(completion)
    }
}


extension Entity {
    convenience init(type: Data.DMEntity) {
        self.init(type: type.rawValue)
    }
}
