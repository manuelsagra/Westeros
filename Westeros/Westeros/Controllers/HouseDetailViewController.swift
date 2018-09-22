//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 12/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    // MARK: - Properties
    var model: House
    
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // Chapuza de Apple, necesaria para Storyboards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addButtons()
        
        // Sincronizamos modelo y vista
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        self.title = self.model.name
        houseNameLabel.text = "Casa \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    func addButtons() {
        let buttonWiki = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(wikiButtonPushed))
        let buttonMembers = UIBarButtonItem(title: "Miembros", style: .plain, target: self, action: #selector(membersButtonPushed))
        
        navigationItem.rightBarButtonItems = [
            buttonWiki,
            buttonMembers            
        ]
    }
    
    @objc func wikiButtonPushed() {
        let webView = HouseWebViewController(model: model)
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    @objc func membersButtonPushed() {
        let membersView = MemberListViewController(model: model.sortedMembers)
        self.navigationController?.pushViewController(membersView, animated: true)
    }
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
}
