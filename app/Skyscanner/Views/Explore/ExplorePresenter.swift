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
    
    // MARK - Lifecycle
    init(view: ExploreViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = ExploreInteractor()
    }
    
}

// MARK: - Private section
extension ExplorePresenter {
    
    private func getFlightsInformation() {
        if !interactor.isSessionCreated() {
            createSession()
            return
        }
        
        getFlights()
    }
    
    private func createSession() {
        view?.showProgress(true)
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
        view?.showProgress(true)
        interactor.getFlights { [weak self] (flights, success, error) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let flights = flights {
                self.view?.loadFlights(flights)
                return
            }
            
            if let error = error {
                self.view?.showMessageWith(title: "Error title", message: error.localizedDescription, actionTitle: "Error action title")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Error title", message: "Error message", actionTitle: "Error action title")
                return
            }
            
        }
    }
    
}

extension ExplorePresenter: ExplorePresenterDelegate {
    
    func viewDidLoad() {
        getFlightsInformation()
    }
    
}
