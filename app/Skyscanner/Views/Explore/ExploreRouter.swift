//
//  ExploreRouter.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class ExploreRouter {
    
    public static func setupModule(navigationController: UINavigationController? = nil) -> ExploreViewController {
        let exploreVC = ExploreViewController()
        exploreVC.presenter = ExplorePresenter(view: exploreVC, navigationController: navigationController)
        return exploreVC
    }
    
}
