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
    
    var checkoffs: [DMCheckoffCard] = [DMCheckoffCard(), DMCheckoffCard()]
    var cards: [DMCard] = [DMPuntCard(), DMDutyCard(), DMDutySheetCard(), DMMoneyCard()]
    fileprivate var addButton: IconButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = Color.grey.lighten4
        
        
        // Feed.
        prepareAddButton()
        prepareNavigationItem()
        prepareTableView()
    }
    

    
    // MARK: UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.TableViewCells.DMCardCell, for: indexPath) as! DMCardTableViewCell
            
            cell.card = self.cards[indexPath.row]
            cell.card?.delegate = self;
            
            switch indexPath.row {
            case 1:
                let testDuty = Duty(dutyName: "Kitchen", date: Date(), description: "Wash the dishes, mop the floors, put away the food.", status: .complete, assignee: DMUser.init(name: "Erick Friis"), checkOffTime: nil, checker: DMUser(name: "Juan Fajardo"), id: 0)
                
                cell.card?.dataSource = testDuty
                
            default:
                break
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.TableViewCells.DMCardCell, for: indexPath) as! DMCardTableViewCell
            
            cell.card = self.checkoffs[indexPath.row]
            cell.card?.delegate = self;
            
            return cell;
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.checkoffs.count
        } else {
            return self.cards.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 1) {
        
            switch indexPath.row {
            case 0, 1:
                return 160
            default:
                return 100
            }
        }
        
        return 100;
    }
    
    
    // MARK: DMCardDelegate
    func cardDidTapButton(_ card: DMCard) {
        if let checkoffCard = card as? DMCheckoffCard {
            checkoffCard.updateToCheckoffView();
        }
    }
}


// MARK: Setup
extension OverviewViewController {
    
    fileprivate func prepareAddButton() {
        addButton = IconButton(image: Icon.cm.add)
        addButton.tintColor = UIColor.white
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
    }
    
    fileprivate func prepareNavigationItem() {
        navigationItem.title = "Dashboard"
        navigationItem.detail = "Speed Kills"
        
        navigationItem.detailLabel.textColor = UIColor.white
        navigationItem.titleLabel.textColor = UIColor.white
        
        guard Session.owner!.isAuthorizedForRole(.social, .hm, .admin) else {
            return
        }
        
        navigationItem.rightViews = [addButton]
    }
    
    fileprivate func prepareTableView() {
        // UI
        self.tableView.backgroundColor = Color.grey.lighten4
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        
        // Data
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        // Other
        self.tableView.register(DMCardTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.TableViewCells.DMCardCell)
    }
}


// MARK: Actions
extension OverviewViewController {
    @objc
    fileprivate func handleAddButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let eventAction = UIAlertAction(title: "New Event", style: .default) { (action) in
            //
        }
        let puntAction = UIAlertAction(title: "New Punt", style: .default) { (action) in
            //
        }
        
        alert.addAction(cancelAction)
        alert.addAction(eventAction)
        alert.addAction(puntAction)
        
        self.presentVC(alert)
    }
}

    }
}




