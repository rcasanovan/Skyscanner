//
//  ExplorePresenter.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

typealias getFlightsCompletionBlock = (Result<PollResponse?>) -> Void
typealias createSessionCompletionBlock = (Result<CreateSessionResponse?>) -> Void

class ExplorePresenter {
    
    private weak var view: ExploreViewInjection?
    private let interactor: ExploreInteractorDelegate
    private var showProgress: Bool = false
    
    // MARK - Lifecycle
    init(view: ExploreViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = ExploreInteractor()
    }
    
}

// MARK: - Private section
extension ExplorePresenter {
    
    private func configureTitle() {
        let stations = interactor.getStations()
        let title = "\(stations.originStation) to \(stations.destinationStation)"
        let dateRange = interactor.getDateRange()
        let subtitle = "\(dateRange.outbounddate.getStringMMMddEEEFormat()) - \(dateRange.inbounddate.getStringMMMddEEEFormat())"
        view?.loadTitle(title, subtitle: subtitle)
    }
    
    private func getFlightsInformation() {
        if !interactor.isSessionCreated() {
            createSession()
            return
        }
        
        getFlights()
    }
    
    private func createSession() {
        view?.showProgress(true, status: "Connecting with Skyscanner")
        interactor.createSession { [weak self] (success, error) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let error = error {
                self.view?.showMessageWith(title: "Error title", message: error.localizedDescription, actionTitle: "Error action title")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Error title", message: "Error message", actionTitle: "Error action title")
                return
            }
            
            self.getFlights()
        }
    }
    
    private func getFlights() {
        if showProgress {
            view?.showProgress(true, status: "Getting flights")
        }
        interactor.getFlights { [weak self] (flights, success, error, allFlightsSync) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let flights = flights, allFlightsSync == false {
                self.view?.loadFlights(flights)
                return
            }
            
            if let error = error {
                if let httpCode = error.httpCode, httpCode.isSessionError {
                    self.getFlightsInformation()
                    return
                }
                self.view?.showMessageWith(title: "Oops... 🧐", message: error.localizedDescription, actionTitle: "Accept")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Oops... 🧐", message: "Something wrong happened. Please try again", actionTitle: "Accept")
                return
            }
            
        }
    }
    
}

extension ExplorePresenter: ExplorePresenterDelegate {
    
    func viewDidLoad() {
        configureTitle()
        showProgress = true
        getFlightsInformation()
    }
    
    func loadNextPage() {
        showProgress = false
        getFlights()
    }
    
    func refreshResults() {
        interactor.clear()
        view?.loadFlights([FlightViewModel]())
        showProgress = true
        getFlightsInformation()
    }
    
    func sortPressed() {
        view?.showMessageWith(title: "Oops... 🧐", message: "This option is under construction and is out of the test purpose", actionTitle: "Accept")
    }
    
    func filterPressed() {
        view?.showMessageWith(title: "Oops... 🧐", message: "This option is under construction and is out of the test purpose", actionTitle: "Accept")
    }
    
}
