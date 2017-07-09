//
//  DMCard.swift
//  Delts Manager
//

//  Created by Juan Diego Fajardo on 6/24/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import UIKit
import Material
import ChameleonFramework

@objc
protocol DMDutyCardDelegate {
    @objc func cardDidTapCheckoffButton(_ card: DMDutyCard)
}

@objc
protocol DMPuntCardDelegate {
//    @objc func cardDidTapCheckoffButton(_ card: DMDutyCard)
}


class DMDutyCard: Card {
    
    var duty: Duty? {
        didSet {
            self.refreshLayout()
        }
    }
    var delegate: DMDutyCardDelegate?
    var checkoffButton: FABButton?
    var timer: Timer?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Checkoff Button
        let checkoffButton = FABButton(image: Icon.bell, tintColor: UIColor.white)
        checkoffButton.backgroundColor = UIColor.flatWhite
        checkoffButton.pulseColor = UIColor.flatBlack
        
        checkoffButton.addTarget(self, action: #selector(checkoffButtonPressed), for: .touchUpInside)
        
        self.checkoffButton = checkoffButton

        // Content View
        let contentView = UILabel()
        contentView.numberOfLines = 0
        contentView.text = "Clean the dishes, mop the dining room floor, and bring food down to the kitchen."
        contentView.font = RobotoFont.regular(with: 14)
        
        self.contentView = contentView
        self.contentViewEdgeInsetsPreset = .wideRectangle3
        self.contentViewEdgeInsets.bottom = 20

        // Toolbar / Title
        let toolbar = Toolbar()
        toolbar.title = "Pantry"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "Checked off by Erick Friis"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
        
        toolbar.rightViews = [checkoffButton]
        
        self.toolbar = toolbar
        self.toolbarEdgeInsetsPreset = .square3
        self.toolbarEdgeInsets.bottom = 10
        self.toolbarEdgeInsets.right = 8
        
        
        // Pulse Timer
        self.timer = Timer(fireAt: Date.init(timeIntervalSinceNow: 0), interval: 3, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc
    func fire() {
        self.checkoffButton?.pulse()
    }
    
    func refreshLayout() {
        self.toolbar?.detail = DMDutyCard.toolbarDetailForDuty(self.duty!)
        self.toolbar?.title = self.duty!.dutyName!
        
        self.checkoffButton?.image = DMDutyCard.checkoffImageForDuty(self.duty!)
        self.checkoffButton?.backgroundColor = DMDutyCard.checkoffBackgroundColorForDuty(self.duty!)
        
        let contentView = self.contentView as! UILabel
        contentView.text = self.duty!.description
        
        setNeedsDisplay()
    }
    
    static func toolbarDetailForDuty(_ duty: Duty) -> String {
        switch duty.status! {
        case .complete:
            return "Checked off by \(duty.checker!.fullName)"
        case .incomplete:
            return "Due by \(duty.date!) at 11:59 PM"
        case .late:
            return "Punted!"
        case .unassigned:
            return "-";
        }
    }
    
    static func checkoffImageForDuty(_ duty: Duty) -> UIImage? {
        switch duty.status! {
        case .complete:
            return Icon.check
        case .incomplete:
            return Icon.bell
        case .late:
            return Icon.close
        case .unassigned:
            return nil
        }
    }
    
    private static func checkoffBackgroundColorForDuty(_ duty: Duty) -> UIColor {
        switch duty.status! {
        case .complete:
            return UIColor.flatMint
        case .incomplete:
            return UIColor.flatPurple
        case .late:
            return UIColor.flatWatermelon
        case .unassigned:
            return UIColor.flatWhite
        }
    }
    
    // Delegate Calls
    @objc
    func checkoffButtonPressed() {
        self.delegate?.cardDidTapCheckoffButton(self)
    }
}


class DMPuntCard: Card {
    
    var actionButton: FABButton?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Venmo Button
        let venmoButton = FABButton(image: #imageLiteral(resourceName: "venmo"))
        venmoButton.backgroundColor = UIColor.init(red: 0.239, green: 0.584, blue: 0.808, alpha: 1.0)
        venmoButton.pulseColor = UIColor.white
        
        self.actionButton = venmoButton
        
        // Other Actions Button
        let actionButton = FABButton(image: Icon.work, tintColor: UIColor.white)
        actionButton.backgroundColor = UIColor.flatPurple
        actionButton.pulseColor = UIColor.white
        
        // Content View
        let contentView = UILabel()
        contentView.numberOfLines = 0
        contentView.text = "Pay $25 or submit a punt makeup request to the House Manager"
        contentView.font = RobotoFont.regular(with: 14)
        
        self.contentView = contentView
        self.contentViewEdgeInsetsPreset = .wideRectangle3
        self.contentViewEdgeInsets.bottom = 20;
        
        // Toolbar / Title View
        let toolbar = Toolbar()
        toolbar.title = "Punt!"
        toolbar.titleLabel.textAlignment = .left
        toolbar.detail = "Given by Social Chair"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
        
        toolbar.rightViews = [actionButton]
        
        self.toolbar = toolbar
        self.toolbarEdgeInsetsPreset = .square3
        self.toolbarEdgeInsets.bottom = 10
        self.toolbarEdgeInsets.right = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



class DMDutySheetCard: Card {
    
    var actionButton: FABButton?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Button
        let actionButton = FABButton(image: Icon.edit, tintColor: UIColor.flatWhite)
        actionButton.backgroundColor = UIColor.flatPurple
        actionButton.pulseColor = UIColor.white

        self.actionButton = actionButton
        
        // Toolbar / Main View
        let toolbar = Toolbar()
        toolbar.title = "Duty Sheet Open!"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "Open until Sun @ 12:00 pm"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
        
        toolbar.rightViews = [actionButton]
        
        self.toolbar = toolbar
        self.toolbarEdgeInsetsPreset = .square3
        self.toolbarEdgeInsets.bottom = 15
        self.toolbarEdgeInsets.right = 8
        
        self.contentViewEdgeInsetsPreset = .wideRectangle3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DMMoneyCard: Card {

    var actionButton: FABButton?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Action Button
        let actionButton = FABButton(image: Icon.moreHorizontal, tintColor: UIColor.white)
        actionButton.backgroundColor = UIColor.flatPurple
        actionButton.pulseColor = UIColor.white
        
        self.actionButton = actionButton
        
        // Money Label
        let moneyLabel = UILabel()
        moneyLabel.numberOfLines = 0
        moneyLabel.text = "$845"
        moneyLabel.font = RobotoFont.regular(with: 24)
        
        // Toolbar
        let toolbar = Toolbar()
        toolbar.title = "House Dues"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "Due by September 7"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
        
        toolbar.rightViews = [moneyLabel, actionButton]
        self.toolbar = toolbar
        
        self.toolbarEdgeInsetsPreset = .square3
        self.toolbarEdgeInsets.bottom = 15
        self.toolbarEdgeInsets.right = 8
        
        self.contentViewEdgeInsetsPreset = .wideRectangle3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
