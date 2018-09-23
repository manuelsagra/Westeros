//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 22/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    // MARK: - Properties
    var model: Season

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Season) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
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
        
        addButton()
        
        syncModelWithView()
    }

    // MARK: - Sync
    func syncModelWithView() {
        self.title = self.model.name
        titleLabel.text = self.model.name
        numberLabel.text = "\(self.model.count) episodios"
        dateLabel.text = model.launchDateToString
    }
    
    func addButton() {
        let buttonEpisodes = UIBarButtonItem(title: "Episodios", style: .plain, target: self, action: #selector(episodesButtonPushed))
        
        navigationItem.rightBarButtonItems = [
            buttonEpisodes
        ]
    }
    
    @objc func episodesButtonPushed() {
        let episodesView = EpisodeListViewController(model: model.sortedEpisodes)
        self.navigationController?.pushViewController(episodesView, animated: true)
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}
