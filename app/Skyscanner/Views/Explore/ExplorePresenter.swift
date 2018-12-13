//
//  ExplorePresenter.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

typealias getFlightsCompletionBlock = (Result<PollResponse?>) -> Void

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
    
    private func getFlights() {
        interactor.getFlights { [weak self] (flights, success, error) in
            guard let `self` = self else { return }
            
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
        getFlights()
    }
    
}
