//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 12/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        let navController = UINavigationController(rootViewController: self)
        
        // Custom color & background
        navController.navigationBar.backgroundColor = UIColor.black
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navController.navigationBar.tintColor = UIColor.white
        
        return navController
    }
}
