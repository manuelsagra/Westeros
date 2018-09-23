//
//  AppDelegate.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 6/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    
    var houseDetailWrapped: UINavigationController!
    var seasonDetailWrapped: UINavigationController!
    var splitViewController: UISplitViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Models
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Master / Detail
        let houseList = HouseListViewController(model: houses)
        let houseDetail = HouseDetailViewController(model: houseList.lastSelectedHouse())
        houseDetailWrapped = houseDetail.wrappedInNavigation()
        
        let seasonList = SeasonListViewController(model: seasons)
        let seasonDetail = SeasonDetailViewController(model: seasonList.lastSelectedSeason())
        seasonDetailWrapped = seasonDetail.wrappedInNavigation()
        
        // Delegates (different in iPhone and iPad)
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            houseList.delegate = houseDetail
            seasonList.delegate = seasonDetail
        } else {
            houseList.delegate = houseList
            seasonList.delegate = seasonList
        }
        
        // TabBar
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            houseList.wrappedInNavigation(),
            seasonList.wrappedInNavigation()
        ]
        tabBar.delegate = self
        
        // Split View
        splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            tabBar,
            houseDetailWrapped
        ]
        
        // Root controller
        window?.rootViewController = splitViewController
        
        window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // iPad only
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            if let navController = viewController as? UINavigationController {
                let typeOfController = type(of: navController.viewControllers.first!)
                var detailController: UINavigationController
                
                switch (typeOfController) {
                case is HouseListViewController.Type:
                    detailController = houseDetailWrapped
                    
                case is SeasonListViewController.Type:
                    detailController = seasonDetailWrapped
                    
                default:
                    NSLog("Unknown controller \(typeOfController)")
                    detailController = UINavigationController()
                }
                
                splitViewController.showDetailViewController(detailController, sender: self)
            }
        }
    }
}

