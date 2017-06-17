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
