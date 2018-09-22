//
//  WesterosSplitViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 22/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

class WesterosSplitViewController: UISplitViewController, UITabBarControllerDelegate {
    // MARK: - Properties
    let houseDetail: UIViewController
    let seasonDetail: UIViewController
    
    // MARK: - Initialization
    init(houseDetail: UIViewController, seasonDetail: UIViewController) {
        self.houseDetail = houseDetail
        self.seasonDetail = seasonDetail
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Delegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let viewTitle = viewController.title {
            switch (viewTitle) {
            case Constants.houseListTitle:
                self.viewControllers[1] = houseDetail
                
            case Constants.seasonListTitle:
                self.viewControllers[1] = seasonDetail
                
            default:
                NSLog("Unexpected title: \(viewTitle)")
            }
        }
    }
}
