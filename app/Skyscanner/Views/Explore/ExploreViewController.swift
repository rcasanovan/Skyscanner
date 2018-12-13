//
//  ExploreViewController.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class ExploreViewController: BaseViewController {
    
    public var presenter: ExplorePresenterDelegate?
    
    private let flightsContainerView: UIView = UIView()
    private var flightsTableView: UITableView?
    private var dataSource: FlightsDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
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
        flightsContainerView.backgroundColor = .clear
        flightsTableView = UITableView(frame: flightsContainerView.bounds, style: .plain)
        flightsTableView?.tableFooterView = UIView()
        flightsTableView?.separatorStyle = .none
        flightsTableView?.rowHeight = UITableView.automaticDimension
        flightsTableView?.invalidateIntrinsicContentSize()
        flightsTableView?.backgroundColor = .lightGray
        flightsTableView?.showsVerticalScrollIndicator = false
        
        registerCells()
        setupDataSource()
    }
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
        flightsTableView?.register(FlightTableViewCell.self, forCellReuseIdentifier: FlightTableViewCell.identifier)
    }
    
    /**
     * Setup datasource for the collection view
     */
    private func setupDataSource() {
        if let flightsTableView = flightsTableView {
            dataSource = FlightsDatasource()
            flightsTableView.dataSource = dataSource
        }
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
        view.addSubview(flightsContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: flightsContainerView)
        view.addConstraintsWithFormat("V:|[v0]|", views: flightsContainerView)
        
        if let flightsTableView = flightsTableView {
            flightsContainerView.addSubview(flightsTableView)
            flightsContainerView.addConstraintsWithFormat("H:|[v0]|", views: flightsTableView)
            flightsContainerView.addConstraintsWithFormat("V:|[v0]|", views: flightsTableView)
        }
    }
    
}

extension ExploreViewController: ExploreViewInjection {
    
    func showProgress(_ show: Bool, status: String) {
        showLoader(show, status: status)
    }
    
    func showProgress(_ show: Bool) {
        showLoader(show)
    }
    
    func loadFlights(_ viewModels: [FlightViewModel]) {
        dataSource?.flights = viewModels
        flightsTableView?.reloadData()
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        super.showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
}
