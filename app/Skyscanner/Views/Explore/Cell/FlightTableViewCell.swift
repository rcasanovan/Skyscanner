//
//  FlightTableViewCell.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    private let outboundFlightView: FlightView = FlightView()
    private let inboundFlightView: FlightView = FlightView()
    private let flightFooterView: FlightFooterView = FlightFooterView()
    
    static public var identifier: String {
        return String(describing: self)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func bindWithViewModel(_ viewModel: FlightViewModel) {
        outboundFlightView.bindWithViewModel(viewModel.outboundInformation)
        inboundFlightView.bindWithViewModel(viewModel.inboundInformation)
        flightFooterView.bindWithViewModel(viewModel)
    }
    
}

// MARK: - Setup views
extension FlightTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
    }
    
}

// MARK: - Layout & constraints
extension FlightTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let bottom: CGFloat = 10.0
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(outboundFlightView)
        addSubview(inboundFlightView)
        addSubview(flightFooterView)
        
        addConstraintsWithFormat("H:|[v0]|", views: outboundFlightView)
        addConstraintsWithFormat("H:|[v0]|", views: inboundFlightView)
        addConstraintsWithFormat("H:|[v0]|", views: flightFooterView)
        
        addConstraintsWithFormat("V:|[v0(\(outboundFlightView.height))][v1(\(inboundFlightView.height))][v2(\(flightFooterView.height))]-\(Layout.bottom)-|", views: outboundFlightView, inboundFlightView, flightFooterView)
    }
    
}
