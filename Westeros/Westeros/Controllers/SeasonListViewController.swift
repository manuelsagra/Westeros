//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 22/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UITableViewController {
    // MARK: - Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [Season]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        title = Constants.seasonListTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let house = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.seasonCell)
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.seasonCell)
        }
        
        cell?.textLabel?.text = house.name
        cell?.detailTextLabel?.text = "\(house.count) episodios"
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seasonObj = season(at: indexPath.row)
        saveLastSelectedSeason(row: indexPath.row)
        
        delegate?.seasonListViewController(self, didSelectSeason: seasonObj)
        
        let nc = NotificationCenter.default
        let notification = Notification(name: .seasonDidChangeNotitication, object: self, userInfo: [Constants.seasonKey: seasonObj])
        nc.post(notification)
    }
}

// MARK: - Persistence (UserDefaults)
extension SeasonListViewController {
    func saveLastSelectedSeason(row: Int) {
        let userDefaults = UserDefaults.standard
        UserDefaults.standard.set(row, forKey: Constants.selectedSeasonKey)
        userDefaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        let userDefaults = UserDefaults.standard
        let row = userDefaults.integer(forKey: Constants.selectedSeasonKey)
        return season(at: row)
    }
    
    func season(at row: Int) -> Season {
        return model[row]
    }
}
