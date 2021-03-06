//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 18/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Miembros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotitication, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let house: House = info[Constants.houseKey] as? House else { return }
        model = house.sortedMembers

        tableView.reloadData()
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let personObj = member(at: indexPath.row)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.personCell)
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.personCell)
        }
        
        cell?.textLabel?.text = personObj.name
        cell?.detailTextLabel?.text = personObj.alias
        cell?.imageView?.image = personObj.photo
        
        return cell!
    }
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personObj = member(at: indexPath.row)
        navigationController?.pushViewController(MemberDetailViewController(model: personObj), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension MemberListViewController {
    func member(at row: Int) -> Person {
        return model[row]
    }
}
