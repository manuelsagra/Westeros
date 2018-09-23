//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 22/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Episode) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        self.title = self.model.title
        titleLabel.text = self.model.title
        numberLabel.text = "Episodio \(self.model.number)"
        dateLabel.text = model.airDateToString
        excerptLabel.text = model.excerpt
    }
}
