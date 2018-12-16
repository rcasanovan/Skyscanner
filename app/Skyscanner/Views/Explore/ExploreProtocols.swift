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
    func loadTitle(_ title: String, subtitle: String)
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func loadFlights(_ viewModels: [FlightViewModel])
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol ExplorePresenterDelegate : class {
    func viewDidLoad()
    func loadNextPage()
    func refreshResults()
    func filterPressed()
    func sortPressed()
}

// Presenter / Interactor
typealias ExploreGetFlightsCompletionBlock = (_ viewModel: [FlightViewModel]?, _ success: Bool, _ error: ResultError?, _ allFlightsSync: Bool) -> Void
typealias ExploreCreateSessionCompletionBlock = (_ success: Bool, _ error: ResultError?) -> Void

protocol ExploreInteractorDelegate : class {
    func clear()
    func isSessionCreated() -> Bool
    func createSession(completion: @escaping ExploreCreateSessionCompletionBlock)
    func getFlights(completion: @escaping ExploreGetFlightsCompletionBlock)
    func getDateRange() -> (outbounddate: Date , inbounddate: Date)
    func getStations() -> (originStation: String, destinationStation: String)
}
