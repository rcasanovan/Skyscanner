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
    
    private let customTitleView: CustomTitleView = CustomTitleView()
    private let headerView: HeaderView = HeaderView()
    private let flightsContainerView: UIView = UIView()
    private var flightsTableView: UITableView?
    private var dataSource: FlightsDatasource?
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private var totalFlights: Int = 0
    private var isLoadingNextPage: Bool = false
    
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
        flightsTableView?.backgroundColor = .lightGray()
        flightsTableView?.showsVerticalScrollIndicator = false
        flightsTableView?.delegate = self
        
        refreshControl.addTarget(self, action: #selector(userDidPullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .black()
        flightsTableView?.addSubview(refreshControl)
        
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
        customTitleView.titleColor = .black()
        customTitleView.subtitleColor = .gray()
        navigationItem.titleView = customTitleView
    }
    
}

// MARK: - Layout & constraints
extension ExploreViewController {
    
    private struct Layout {
        
        struct Scroll {
            static let percentagePosition: Double = 75.0
        }
        
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(flightsContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: headerView)
        view.addConstraintsWithFormat("V:|[v0(\(headerView.height))]", views: headerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: flightsContainerView)
        view.addConstraintsWithFormat("V:[v0][v1]|", views: headerView, flightsContainerView)
        
        if let flightsTableView = flightsTableView {
            flightsContainerView.addSubview(flightsTableView)
            flightsContainerView.addConstraintsWithFormat("H:|[v0]|", views: flightsTableView)
            flightsContainerView.addConstraintsWithFormat("V:|[v0]|", views: flightsTableView)
        }
    }
    
}

// MARK: - User actions
extension ExploreViewController {
    
    @objc private func userDidPullToRefresh() {
        presenter?.refreshResults()
    }
    
}

// MARK: - UITableViewDelegate
extension ExploreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Get the position for a percentage of the scrolling
        // In this case we got the positions for the 75%
        let position = Int(((Layout.Scroll.percentagePosition * Double(totalFlights - 1)) / 100.0))
        
        // if we're not loading a next page && we´re in the 75% position
        if !self.isLoadingNextPage && indexPath.item == position {
            // Change the value -> We're loading the next page
            self.isLoadingNextPage = true
            // Call the presenter
            presenter?.loadNextPage()
        }
    }
    
}

extension ExploreViewController: ExploreViewInjection {
    
    func loadTitle(_ title: String, subtitle: String) {
        customTitleView.setTitle(title)
        customTitleView.setSubtitle(subtitle)
    }
    
    func showProgress(_ show: Bool, status: String) {
        showLoader(show, status: status)
    }
    
    func showProgress(_ show: Bool) {
        showLoader(show)
    }
    
    func loadFlights(_ viewModels: [FlightViewModel]) {
        refreshControl.endRefreshing()
        headerView.bindWithTitle("\(viewModels.count) results shown")
        isLoadingNextPage = false
        totalFlights = viewModels.count
        dataSource?.flights = viewModels
        flightsTableView?.reloadData()
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        super.showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
}
