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
    
//    public func bindWithViewModel(_ viewModel: HDAccountViewModel) {
//        titleLabel.text = "Mi cuenta"
//        emailLabel.text = viewModel.title
//
//        if let urlString = viewModel.userImageUrl, let url = URL(string: urlString) {
//            userImageView.hnk_setImage(from: url, placeholder: nil)
//        }
//    }
    
}

// MARK: - Setup views
extension FlightTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .white
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
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(outboundFlightView)
        addSubview(inboundFlightView)
        
        addConstraintsWithFormat("H:|[v0]|", views: outboundFlightView)
        addConstraintsWithFormat("H:|[v0]|", views: inboundFlightView)
        
        addConstraintsWithFormat("V:|[v0(\(outboundFlightView.height))][v1(\(inboundFlightView.height))]|", views: outboundFlightView, inboundFlightView)
    }
    
}
