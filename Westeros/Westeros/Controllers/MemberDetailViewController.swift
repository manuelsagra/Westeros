//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 22/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    // MARK: - Properties
    var model: Person
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    // MARK: - Initialization
    init(model: Person) {
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
        self.title = self.model.name
        nameLabel.text = self.model.name
        houseLabel.text = "Casa \(self.model.house.name)"
        aliasLabel.text = self.model.alias
        photoImage.image = self.model.photo
    }
}
