//
//  OverviewViewController.swift
//  Delts Manager
//
//  Created by Juan Diego Fajardo on 6/22/17.
//  Copyright © 2017 Delta Tau Delta. All rights reserved.
//

import UIKit
import Material

class OverviewViewController: UITableViewController, DMCardDelegate {
    
    var cards: [DMCard] = [DMPuntCard(), DMDutyCard(), DMDutySheetCard(), DMMoneyCard()]
    
    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    fileprivate var searchButton: IconButton!
    
    fileprivate var fabButton: FABButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarItem.image = Icon.cm.star?.tint(with: Color.blueGrey.base)
        tabBarItem.selectedImage = Icon.cm.star?.tint(with: Color.blue.base)
        
        self.view.backgroundColor = Color.grey.lighten4
        
        self.tableView.backgroundColor = Color.grey.lighten4
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        self.tableView.register(DMCardTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.TableViewCells.DMCardCell)
        
        
        prepareMenuButton()
        prepareStarButton()
        prepareSearchButton()
        prepareNavigationItem()
        prepareFABButton()
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
    func cardDidTapButton(_ card: DMCard) {
        print("Button Pressed!")
    }
    
    
    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.TableViewCells.DMCardCell, for: indexPath) as! DMCardTableViewCell
        
        cell.card = self.cards[indexPath.row]
        
        switch indexPath.row {
        case 1:
            let testDuty = Duty(dutyName: "Kitchen", date: Date(), description: "Wash the dishes, mop the floors, put away the food.", status: .complete, assignee: DMUser.init(name: "Erick Friis"), checkOffTime: nil, checker: DMUser(name: "Juan Fajardo"), id: 0)
            
            cell.card?.dataSource = testDuty
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1:
            return 160
        default:
            return 100
        }
    }
}

extension OverviewViewController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor = UIColor.flatWhite
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.star)
        starButton.tintColor = UIColor.white
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search)
        searchButton.tintColor = UIColor.flatWhite
    }
    
    fileprivate func prepareNavigationItem() {
        navigationItem.title = "Today"
        navigationItem.detail = "Speed Kills"
        
        navigationItem.detailLabel.textColor = UIColor.white
        navigationItem.titleLabel.textColor = UIColor.white
        
        navigationItem.leftViews = [menuButton]
        navigationItem.rightViews = [starButton, searchButton]
        
    }
    
    fileprivate func prepareFABButton() {
        fabButton = FABButton(image: Icon.cm.photoCamera)
        fabButton.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        view.layout(fabButton).width(64).height(64).bottom(24).right(24)
    }
}

extension OverviewViewController {
    @objc
    fileprivate func handleNextButton() {
//        navigationController?.pushViewController(TransitionViewController(), animated: true)
    }
}




