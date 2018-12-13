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
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func loadFlights(_ viewModels: [FlightViewModel])
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol ExplorePresenterDelegate : class {
    func viewDidLoad()
    func loadNextPage()
}

// Presenter / Interactor
typealias ExploreGetFlightsCompletionBlock = (_ viewModel: [FlightViewModel]?, _ success: Bool, _ error: ResultError?) -> Void
typealias ExploreCreateSessionCompletionBlock = (_ success: Bool, _ error: ResultError?) -> Void

protocol ExploreInteractorDelegate : class {
    func isSessionCreated() -> Bool
    func createSession(completion: @escaping ExploreCreateSessionCompletionBlock)
    func getFlights(completion: @escaping ExploreGetFlightsCompletionBlock)
}
