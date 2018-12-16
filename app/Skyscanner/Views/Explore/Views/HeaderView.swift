//
//  HeaderView.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 16/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    private let filterButton: UIButton = UIButton(type: .custom)
    private let sortButton: UIButton = UIButton(type: .custom)
    private let titleLabel: UILabel = UILabel()
    
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
    
    public func bindWithTitle(_ title: String) {
        titleLabel.text = title
    }
    
}

// MARK: - Setup views
extension HeaderView {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        filterButton.titleLabel?.font = UIFont.interUIMediumWithSize(size: 13.0)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(.blue, for: .normal)
        
        sortButton.titleLabel?.font = UIFont.interUIMediumWithSize(size: 13.0)
        sortButton.setTitle("Sort", for: .normal)
        sortButton.setTitleColor(.blue, for: .normal)
        
        titleLabel.font = UIFont.interUIMediumWithSize(size: 13.0)
        titleLabel.textColor = .gray()
        titleLabel.text = "-"
    }
    
}

// MARK: - Layout & constraints
extension HeaderView {
    
    private struct Layout {
        
        static let height: CGFloat = 40.0
        
    }
    
    private func addSubviews() {
        addSubview(filterButton)
        addSubview(sortButton)
        addSubview(titleLabel)
        
        addConstraintsWithFormat("H:[v0(50.0)]-20.0-|", views: filterButton)
        addConstraintsWithFormat("V:|[v0]|", views: filterButton)
        
        addConstraintsWithFormat("H:[v0(50.0)]-10.0-[v1]", views: sortButton, filterButton)
        addConstraintsWithFormat("V:|[v0]|", views: sortButton)
        
        addConstraintsWithFormat("H:|-20.0-[v0]-20.0-[v1]", views: titleLabel, sortButton)
        addConstraintsWithFormat("V:|[v0]|", views: titleLabel)
    }
    
}
