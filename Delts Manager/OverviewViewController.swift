//
//  OverviewViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/22/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import UIKit
import Material

class OverviewViewController: UIViewController, DMDutyCardDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarItem.image = Icon.cm.star?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.cm.star?.tint(with: Color.blue.base)
        self.view.backgroundColor = Color.grey.lighten4
        
        let card = DMDutyCard()
        card.delegate = self
        
        card.duty = Duty(dutyName: "Kitchen", date: Date(), description: "Wash the dishes, mop the floors, put away the food.", status: .checkoffRequested, assignee: DMUser.init(name: "Erick Friis"), checkOffTime: nil, checker: DMUser(name: "Juan Fajardo"), id: 0)
        
        let card3 = DMPuntCard()
        
        let card2 = DMDutySheetCard()
        
        let card4 = DMMoneyCard()
        
        
        view.layout(card).horizontally(left: 20, right: 20).top(50 + 35)
        view.layout(card3).horizontally(left: 20, right: 20).top(card.height + 75 + 25)
        view.layout(card2).horizontally(left: 20, right: 20).top(card.height + card3.height + 110)
        view.layout(card4).horizontally(left: 20, right: 20).bottom(60)
        
        card.setNeedsDisplay()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // MARK: DMCardDelegate
    func cardDidTapCheckoffButton(_ card: DMDutyCard) {
        
        switch card.checkoffButton!.backgroundColor! {
        case UIColor.flatWhite:
            if card.checkoffButton!.image! == Icon.bell {
                card.checkoffButton?.backgroundColor = UIColor.flatPurple
                card.checkoffButton?.tintColor = UIColor.white
            } else {
                card.checkoffButton?.backgroundColor = UIColor.flatMint
                card.checkoffButton?.tintColor = UIColor.white
            }
            
            break
            
        case UIColor.flatPurple:
            card.checkoffButton?.backgroundColor = UIColor.flatWhite
            card.checkoffButton?.image = Icon.check
            card.checkoffButton?.tintColor = UIColor.white
            break
        case UIColor.flatMint:
            card.checkoffButton?.backgroundColor = UIColor.flatWatermelon
            card.checkoffButton?.image = Icon.close
            break
            
        case UIColor.flatWatermelon:
            card.checkoffButton?.backgroundColor = UIColor.flatWhite
            card.checkoffButton?.image = Icon.bell
            card.checkoffButton?.tintColor = UIColor.white
        default:
            break
        }
        
    }
    

}
