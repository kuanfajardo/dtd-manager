//
//  TabBarController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/22/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import UIKit
import Material

class TabBarController: BottomNavigationController {
    
    override func viewDidLoad() {
//        self.viewControllers
        tabBar.depthPreset = .none
        tabBar.dividerColor = Color.grey.lighten3
    }
    
}
