//
//  FlightFooterView.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class FlightFooterView: UIView {
    
    private let priceLabel: UILabel = UILabel()
    
    public var height: CGFloat {
        return Layout.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public func bindWithViewModel(_ viewModel: FlightInformationViewModel) {
    }
    
}

// MARK: - Setup views
extension FlightFooterView {
    
    private func setupViews() {
        backgroundColor = .yellow
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        priceLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
    }
    
}

// MARK: - Layout & constraints
extension FlightFooterView {
    
    private struct Layout {
        
        static let height: CGFloat = 100.0
        
        struct PriceLabel {
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 20.0
            static let height: CGFloat = 24.0
            static let width: CGFloat = 60.0
        }
        
    }
    
    private func addSubviews() {
        addSubview(priceLabel)
        
        addConstraintsWithFormat("H:[V0(\(Layout.PriceLabel.width))]-\(Layout.PriceLabel.trailing)-|", views: priceLabel)
        addConstraintsWithFormat("V:|-\(Layout.PriceLabel.top)-[v0(\(Layout.PriceLabel.height))]", views: priceLabel)
    }
    
}
