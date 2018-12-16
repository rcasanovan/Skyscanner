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
    
    public func bindWithViewModel(_ viewModel: FlightInformationViewModel) {
        if let airlineUrl = viewModel.airlineUrl {
            airlineImageView.hnk_setImage(from: airlineUrl)
        }
        timeLabel.text = viewModel.time
        informationLabel.text = viewModel.information
        connectionLabel.text = viewModel.connection
        durationLabel.text = viewModel.duration
    }
    
    public func clear() {
        timeLabel.text = ""
        informationLabel.text = ""
        connectionLabel.text = ""
        durationLabel.text = ""
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
        airlineImageView.backgroundColor = .clear
        airlineImageView.contentMode = .scaleAspectFit
        airlineImageView.frame = CGRect(x: 0.0, y: 0.0, width: Layout.AirlineImageView.width, height: Layout.AirlineImageView.height)
        
        timeLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        timeLabel.textColor = .black
        
        informationLabel.font = UIFont.systemFont(ofSize: 14.0)
        informationLabel.textColor = .black
        
        connectionLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        connectionLabel.textColor = .black
        connectionLabel.textAlignment = .right
        
        durationLabel.font = UIFont.systemFont(ofSize: 14.0)
        durationLabel.textColor = .black
        durationLabel.textAlignment = .right
    }

}

// MARK: - Layout & constraints
extension FlightView {
    
    private struct Layout {
        
        static let height: CGFloat = 80.0
        
        struct AirlineImageView {
            static let leading: CGFloat = 10.0
            static let top: CGFloat = 20.0
            static let bottom: CGFloat = 25.0
            static let height: CGFloat = 30.0
            static let width: CGFloat = 30.0
        }
        
        struct ConnectionLabel {
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 20.0
            static let width: CGFloat = 60.0
        }
        
        struct DurationLabel {
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 16.0
            static let width: CGFloat = 60.0
        }
        
        struct TimeLabel {
            static let leading: CGFloat = 10.0
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 20.0
        }
        
        struct InformationLabel {
            static let leading: CGFloat = 10.0
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 16.0
        }
        
    }
    
    private func addSubviews() {
        addSubview(airlineImageView)
        addSubview(connectionLabel)
        addSubview(durationLabel)
        addSubview(timeLabel)
        addSubview(informationLabel)
        
        addConstraintsWithFormat("H:|-\(Layout.AirlineImageView.leading)-[v0(\(Layout.AirlineImageView.width))]", views: airlineImageView)
        addConstraintsWithFormat("V:|-\(Layout.AirlineImageView.top)-[v0(\(Layout.AirlineImageView.height))]-\(Layout.AirlineImageView.bottom)-|", views: airlineImageView)
        
        addConstraintsWithFormat("H:[v0(\(Layout.ConnectionLabel.width))]-(\(Layout.ConnectionLabel.trailing))-|", views: connectionLabel)
        addConstraintsWithFormat("V:|-\(Layout.ConnectionLabel.top)-[v0(\(Layout.ConnectionLabel.height))]", views: connectionLabel)
        
        addConstraintsWithFormat("H:[v0(\(Layout.DurationLabel.width))]-(\(Layout.DurationLabel.trailing))-|", views: durationLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.DurationLabel.top)-[v1(\(Layout.DurationLabel.height))]", views: connectionLabel, durationLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.TimeLabel.leading)-[v1]-(\(Layout.TimeLabel.trailing))-[v2]", views: airlineImageView, timeLabel, connectionLabel)
        addConstraintsWithFormat("V:|-\(Layout.TimeLabel.top)-[v0(\(Layout.TimeLabel.height))]", views: timeLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.InformationLabel.leading)-[v1]-(\(Layout.InformationLabel.trailing))-[v2]", views: airlineImageView, informationLabel, connectionLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.ConnectionLabel.top)-[v1(\(Layout.ConnectionLabel.height))]", views: timeLabel, informationLabel)
    }
    
}
