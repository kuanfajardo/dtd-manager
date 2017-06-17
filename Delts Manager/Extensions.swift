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


// Extension for parsing FBDB as SwiftyJSON
extension DataSnapshot {
    var json: JSON {
        let dict = self.value as? [String : AnyObject]
        return JSON(dict!)
    }
}
