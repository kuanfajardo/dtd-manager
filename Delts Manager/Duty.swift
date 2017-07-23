//
//  Duty.swift
//  Delts Manager
//
//  Created by Andre Curiel on 6/11/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import Foundation
import SwiftyJSON
import Material
import ChameleonFramework

class Duty: Event {
    // Instance variables
    var status: Constants.DutyStatus?
    var assignee: DMUser?
    var checkOffTime: Date?
    var checker: DMUser?
    var dutyName: String? {
        return self.title
    }
    
    // Initialization
    init(dutyName: String, date: Date, description: String, status: Constants.DutyStatus, assignee: DMUser, checkOffTime: Date?, checker: DMUser, id: Int) {
        super.init(id: id, title: dutyName)

        self.date = date
        self.description = description

        self.status = status
        self.assignee = assignee
        self.checkOffTime = checkOffTime
        self.checker = checker
    }

    init(id: Int) {
        super.init(id: id, title: "Duty")
    }
    
    convenience init(json: JSON, id: Int) {
        let dutyName = Session.session.dutyNameForID(json["duty"].stringValue)
        let dateString = json["date"].stringValue
        let description = json["description"].stringValue
        let status = Constants.DutyStatus(rawValue: json["status"].stringValue)!
        let assignee = Session.session.owner!
        let checkTimeString = json["checktime"].stringValue
        let checkerName = Session.session.deltForUsername(json["checker"].stringValue)
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = df.date(from: dateString)
//        let checkDate = 
        
        self.init(dutyName: dutyName, date: date!, description: description, status: status, assignee: assignee, checkOffTime: nil, checker: DMUser(name: checkerName), id: id)
    }
}

extension Duty: Equatable {
    static func == (lhs: Duty, rhs: Duty) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Duty: DMCardDataSource {
    func titleForCard(_ card: DMCard) -> String {
        return self.dutyName!
    }
    
    func detailForCard(_ card: DMCard) -> String {
        switch self.status! {
        case .complete:
            return "Checked off by \(self.checker!.fullName)"
        case .incomplete:
            return "Due by \(self.date!) at 11:59 PM"
        case .late:
            return "Punted!"
        case .unassigned:
            return "-";
        case .checkoffRequested:
            return "Checkoff requested. Waiting for checker..."
        case .pickedUp:
            return "Picked Up by \(self.checker!.fullName)"
        }
    }
    
    func contentForCard(_ card: DMCard) -> String {
        return self.description!
    }
    
    func buttonImageForCard(_ card: DMCard) -> UIImage? {
        switch self.status! {
        case .complete, .pickedUp:
            return Icon.check
        case .incomplete, .checkoffRequested:
            return Icon.bell
        case .late:
            return Icon.close
        case .unassigned:
            return nil
        }
    }
    
    
    func buttonBackgroundColorForCard(_ card: DMCard) -> UIColor {
        switch self.status! {
        case .complete:
            return UIColor.flatMint
        case .incomplete, .checkoffRequested:
            return UIColor.flatPurple
        case .late:
            return UIColor.flatWatermelon
        case .unassigned, .pickedUp:
            return UIColor.flatWhite
        }
    }
}
