//
//  DutiesViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/22/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import UIKit
import Material

class DutiesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        prepareTabBarItem()
    }
    
    func prepareTabBarItem() {
        tabBarItem.image = Icon.cm.photoCamera?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.cm.photoCamera?.tint(with: Color.blue.base)
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

}
