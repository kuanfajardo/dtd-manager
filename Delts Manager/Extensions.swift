//
//  Extensions.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/13/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON
import Graph

extension Entity {
    convenience init(type: Data.DMEntity) {
        self.init(type: type.rawValue)
    }
    
    func `is`(relationship: Data.DMRelationship) -> Relationship {
        return self.is(relationship: relationship.rawValue)
    }
    
    func relationship(types: Data.DMRelationship...) -> [Relationship] {
        return self.relationship(types: types.map({ (r) -> String in
            r.rawValue
        }))
    }
}

extension Search {
    func `for`(types: Data.DMEntity...) -> Search {
        return self.for(types: types.map({ (entity) -> String in
            entity.rawValue
        }))
    }
}

extension Array where Element: Relationship {
    func subject(types: Data.DMEntity...) -> [Entity] {
        return self.subject(types: types.map({ (t) -> String in
            t.rawValue
        }))
    }
}

// Extension for parsing FBDB as SwiftyJSON
extension DataSnapshot {
    var json: SwiftyJSON.JSON {
        if self.value is NSDictionary {
            let data = self.value as! [String : Any]
            return JSON(data)
        } else if self.value is NSArray {
            let data = self.value as! [Any]
            return JSON(data)
        } else {
            return JSON(self.value!)
        }
    }
}


