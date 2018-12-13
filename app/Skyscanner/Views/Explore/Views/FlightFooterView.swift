//
//  FlightFooterView.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class FlightFooterView: UIView {
    
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
    }
    
}

// MARK: - Layout & constraints
extension FlightFooterView {
    
    private struct Layout {
        
        static let height: CGFloat = 100.0
        
    }
    
    private func addSubviews() {
        
    }
    
}
