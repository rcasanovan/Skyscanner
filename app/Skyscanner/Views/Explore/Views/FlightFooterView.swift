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
    private let bookingLabel: UILabel = UILabel()
    private let ratingLabel: UILabel = UILabel()
    private let informationLabel: UILabel = UILabel()
    
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
    
    public func bindWithViewModel(_ viewModel: FlightViewModel) {
        priceLabel.text = viewModel.price
        bookingLabel.text = viewModel.bookingInformation
        ratingLabel.text = viewModel.rating
        informationLabel.text = viewModel.information
    }
    
    public func clear() {
        priceLabel.text = ""
        bookingLabel.text = ""
        ratingLabel.text = ""
        informationLabel.text = ""
    }
    
}

// MARK: - Setup views
extension FlightFooterView {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        priceLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
        
        bookingLabel.font = UIFont.systemFont(ofSize: 14.0)
        bookingLabel.textColor = .black
        bookingLabel.textAlignment = .right
        
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        ratingLabel.textColor = .black
        
        informationLabel.font = UIFont.systemFont(ofSize: 15.0)
        informationLabel.textColor = .green
    }
    
}

// MARK: - Layout & constraints
extension FlightFooterView {
    
    private struct Layout {
        
        static let height: CGFloat = 100.0
        
        struct PriceLabel {
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 25.0
            static let height: CGFloat = 26.0
            static let width: CGFloat = 60.0
        }
        
        struct BookingLabel {
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 16.0
            static let width: CGFloat = 180.0
        }
        
        struct RatingLabel {
            static let leading: CGFloat = 10.0
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 35.0
            static let height: CGFloat = 17.0
        }
        
        struct InformationLabel {
            static let leading: CGFloat = 10.0
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 17.0
        }
        
    }
    
    private func addSubviews() {
        addSubview(priceLabel)
        addSubview(bookingLabel)
        addSubview(ratingLabel)
        addSubview(informationLabel)
        
        addConstraintsWithFormat("H:[v0(\(Layout.PriceLabel.width))]-\(Layout.PriceLabel.trailing)-|", views: priceLabel)
        addConstraintsWithFormat("V:|-\(Layout.PriceLabel.top)-[v0(\(Layout.PriceLabel.height))]", views: priceLabel)
        
        addConstraintsWithFormat("H:[v0(\(Layout.BookingLabel.width))]-\(Layout.BookingLabel.trailing)-|", views: bookingLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.BookingLabel.top)-[v1(\(Layout.BookingLabel.height))]", views: priceLabel, bookingLabel)
        
        addConstraintsWithFormat("H:|-\(Layout.RatingLabel.leading)-[v0]-\(Layout.RatingLabel.trailing)-[v1]", views: ratingLabel, priceLabel)
        addConstraintsWithFormat("V:|-\(Layout.RatingLabel.top)-[v0(\(Layout.RatingLabel.height))]", views: ratingLabel)
        
        addConstraintsWithFormat("H:|-\(Layout.InformationLabel.leading)-[v0]-\(Layout.InformationLabel.trailing)-[v1]", views: informationLabel, bookingLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.InformationLabel.top)-[v1(\(Layout.InformationLabel.height))]", views: ratingLabel, informationLabel)
    }
    
}
