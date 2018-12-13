//
//  ExploreProtocols.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

// View / Presenter
protocol ExploreViewInjection : class {
    func loadFlights(_ viewModels: [FlightViewModel])
}

protocol ExplorePresenterDelegate : class {
    func viewDidLoad()
}
