//
//  ExploreViewController.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class ExploreViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

// MARK: - Setup views
extension ExploreViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        showTitle = true
        
        configureNavigationBar()
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
    }
    
    private func configureNavigationBar() {
        let customTitleView = CustomTitleView()
        customTitleView.titleColor = .black
        customTitleView.setTitle("Edinburgh to London")
        navigationItem.titleView = customTitleView
    }
    
}

// MARK: - Layout & constraints
extension ExploreViewController {
    
    private func addSubviews() {
    }
    
}
