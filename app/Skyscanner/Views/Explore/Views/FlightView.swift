//
//  FlightView.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class FlightView: UIView {
    
    private let airlineImageView: UIImageView = UIImageView()
    private let timeLabel: UILabel = UILabel()
    private let informationLabel: UILabel = UILabel()
    private let connectionLabel: UILabel = UILabel()
    private let durationLabel: UILabel = UILabel()
    
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
    
}

// MARK: - Setup views
extension FlightView {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        airlineImageView.backgroundColor = .yellow
        
        timeLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        timeLabel.textColor = .black
        
        informationLabel.font = UIFont.systemFont(ofSize: 14.0)
        informationLabel.textColor = .black
        
        connectionLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        connectionLabel.textColor = .black
        
        durationLabel.font = UIFont.systemFont(ofSize: 14.0)
        durationLabel.textColor = .black
    }

}

// MARK: - Layout & constraints
extension FlightView {
    
    private struct Layout {
        
        static let height: CGFloat = 80.0
        
        struct AirlineImageView {
            static let leading: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let bottom: CGFloat = 10.0
            static let height: CGFloat = 60.0
            static let width: CGFloat = 60.0
        }
        
        struct ConnectionLabel {
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let bottom: CGFloat = 10.0
            static let height: CGFloat = 60.0
            static let width: CGFloat = 60.0
        }
        
    }
    
    private func addSubviews() {
        addSubview(airlineImageView)
        
        addConstraintsWithFormat("H:|-\(Layout.AirlineImageView.leading)-[v0(\(Layout.AirlineImageView.width))]", views: airlineImageView)
        addConstraintsWithFormat("V:|-\(Layout.AirlineImageView.top)-[v0(\(Layout.AirlineImageView.height))]-\(Layout.AirlineImageView.bottom)-|", views: airlineImageView)
    }
    
}
