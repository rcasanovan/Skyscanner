//
//  MainTabBar.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    private var tabBarConfigured: Bool = false
    
    private let searchViewController: SearchViewController = SearchRouter.setupModule()
    private let exploreViewController: ExploreViewController = ExploreRouter.setupModule()
    private let profileViewController: ProfileViewController = ProfileRouter.setupModule()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
    }
    
}

// MARK: - Private section
extension MainTabBar {
    
    private func configureTabBar() {
        if tabBarConfigured { return }
        
        let searchTabBarItem = UITabBarItem(title: "Search", image: nil, tag: 0)
        let exploreTabBarItem = UITabBarItem(title: "Explore", image: nil, tag: 1)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
        
        let searchNagivationViewController = UINavigationController(rootViewController: searchViewController)
        searchNagivationViewController.tabBarItem = searchTabBarItem
        
        let exploreNagivationViewController = UINavigationController(rootViewController: exploreViewController)
        exploreNagivationViewController.tabBarItem = exploreTabBarItem
        
        let profileNagivationViewController = UINavigationController(rootViewController: profileViewController)
        profileNagivationViewController.tabBarItem = profileTabBarItem
        
        viewControllers = [searchNagivationViewController, exploreNagivationViewController, profileNagivationViewController]
        
        tabBarConfigured = true
    }
    
}
