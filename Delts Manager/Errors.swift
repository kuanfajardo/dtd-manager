//
//  Errors.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/12/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import JSSAlertView

enum ErrorTypes : String {
    case SignInFailedError = "Login Failed"
}

struct Errors {
    
    static func presentError(_ error: ErrorTypes, onController controller: UIViewController, withMessage message: String) {
        _ = JSSAlertView().warning(
            controller,
            title: error.rawValue,
            text: message,
            buttonText: "Dismiss"
        )
    }
}
