//
//  ExplorePresenter.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class ExplorePresenter {
    
    private weak var view: ExploreViewInjection?
    
    // MARK - Lifecycle
    init(view: ExploreViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
    }
    
}

extension ExplorePresenter: ExplorePresenterDelegate {
    
    func viewDidLoad() {
    }
    
}
