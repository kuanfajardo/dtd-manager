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
protocol DMCardDataSource {
    func titleForCard(_ card: DMCard) -> String
    func detailForCard(_ card: DMCard) -> String
    func buttonImageForCard(_ card: DMCard) -> UIImage?
    
    @objc optional func contentForCard(_ card: DMCard) -> String
    @objc optional func moreDetailForCard(_ card: DMCard) -> String
    @objc optional func buttonBackgroundColorForCard(_ card: DMCard) -> UIColor
}

@objc
protocol DMCardDelegate {
    @objc func cardDidTapButton(_ card: DMCard)
}

class DMCard: Card {
    var priority: Int = 0;
    
    var button: FABButton?
    var contentLabel: UILabel?
    var moreDetailLabel: UILabel?
    
    var dataSource: DMCardDataSource? {
        didSet {
            self.refresh()
        }
    }
    
    var delegate: DMCardDelegate?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Checkoff Button
        let button = FABButton(image: Icon.bell, tintColor: UIColor.white)
        button.backgroundColor = UIColor.flatPurple
        button.pulseColor = UIColor.flatWhite
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.button = button
        
        // More Detail Label
        let moreLabel = UILabel()
        moreLabel.numberOfLines = 0
        moreLabel.text = ""
        moreLabel.font = RobotoFont.regular(with: 24)
        
        self.moreDetailLabel = moreLabel
        
        // Toolbar / Title
        let toolbar = Toolbar()
        toolbar.title = "Pantry"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "Checked off by Erick Friis"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.grey.base
        
        toolbar.rightViews = [self.moreDetailLabel!, self.button!]
        
        self.toolbar = toolbar
        self.toolbarEdgeInsetsPreset = .square3
        self.toolbarEdgeInsets.bottom = 10 // (or 15)
        self.toolbarEdgeInsets.right = 8
        
        // Content View
        let contentView = UILabel()
        contentView.numberOfLines = 0
        contentView.text = "Clean the dishes, mop the dining room floor, and bring food down to the kitchen."
        contentView.font = RobotoFont.regular(with: 14)
        
        self.contentLabel = contentView
        self.contentView = self.contentLabel
        self.contentViewEdgeInsetsPreset = .wideRectangle3
        self.contentViewEdgeInsets.bottom = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func refresh() {
        self.toolbar?.detail = self.dataSource?.detailForCard(self)
        self.toolbar?.title = self.dataSource?.titleForCard(self)
        
        self.button?.image = self.dataSource?.buttonImageForCard(self)
        
        if let backgroundColorFunc = self.dataSource?.buttonBackgroundColorForCard {
            self.button?.backgroundColor = backgroundColorFunc(self)
        }
        
        if let moreDetailFunc = self.dataSource?.moreDetailForCard {
            self.moreDetailLabel?.text = moreDetailFunc(self)
        }
        
        if let contentFunc = self.dataSource?.contentForCard {
            self.contentLabel?.text = contentFunc(self)
            self.contentView = self.contentLabel
            self.toolbarEdgeInsets.bottom = 10
            
        } else {
            self.contentView = nil
            self.toolbarEdgeInsets.bottom = 15
        }
        
        self.setNeedsDisplay();
        self.setNeedsLayout()
    }

    
    func buttonPressed() {
        self.delegate?.cardDidTapButton(self)
    }
}


class DMDutyCard: DMCard {
    
    var timer: Timer?
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Pulse Timer
        self.timer = Timer(fireAt: Date.init(timeIntervalSinceNow: 0), interval: 3, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc
    func fire() {
        self.button?.pulse()
    }
}


class DMPuntCard: DMCard {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.button?.image = Icon.work
        self.contentLabel?.text = "Pay $25 or submit a punt makeup request to the House Manager"
        self.toolbar?.title = "Punt!"
        self.toolbar?.detail = "Given by Social Chair"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



class DMDutySheetCard: DMCard {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.button?.image = Icon.edit
        self.toolbar?.title = "Duty Sheet Open!"
        self.toolbar?.detail = "Open until Sun @ 12:00 pm"
        self.contentLabel?.text = ""
        self.toolbarEdgeInsets.bottom = 15;
        self.contentView = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DMMoneyCard: DMCard {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.button?.image = Icon.moreHorizontal
        self.moreDetailLabel?.text = "$845"
        self.toolbar?.title = "House Dues"
        self.toolbar?.detail = "Due by September 7"
        self.contentLabel?.text = ""
        self.toolbarEdgeInsets.bottom = 15;
        self.contentView = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
