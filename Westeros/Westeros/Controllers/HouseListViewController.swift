//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 17/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate {
    // Should
    // Will
    // Did
    
    // Primer parámetro siempre el objeto del que somos delegado
    
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House)
}

class HouseListViewController: UITableViewController {
    // MARK: - Properties
    let model: [House]
    var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [House]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Notifications
    @objc func houseDidChange() {

    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "HouseCell"
        
        let house = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let houseViewController = HouseDetailViewController(model: model[indexPath.row])
        //splitViewController?.showDetailViewController(houseViewController.wrapperInNavigation(), sender: self)
        let houseObj = house(at: indexPath.row)
        saveLastSelectedHouse(row: indexPath.row)
        
        delegate?.houseListViewController(self, didSelectHouse: houseObj)
        
        let nc = NotificationCenter.default
        let notification = Notification(name: .houseDidChangeNotitication, object: self, userInfo: [Constants.houseKey: houseObj])
        nc.post(notification)
    }
}

// MARK: - Persistence (UserDefaults)
extension HouseListViewController {
    func saveLastSelectedHouse(row: Int) {
        let userDefaults = UserDefaults.standard
        UserDefaults.standard.set(row, forKey: Constants.selectedHouseKey)
        userDefaults.synchronize()
    }
    
    func lastSelectedHouse() -> House {
        let userDefaults = UserDefaults.standard
        let row = userDefaults.integer(forKey: Constants.selectedHouseKey)
        return house(at: row)
    }
    
    func house(at row: Int) -> House {
        return model[row]
    }
}
