//
//  ExploreInteractor.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

class ExploreInteractor {
    
    private let requestManager = RequestManager()
    
}

// MARK: - Private section
extension ExploreInteractor {
    
    private func getFlightsWith(completion: @escaping getFlightsCompletionBlock) {
        //__ TODO
    }
    
}

// MARK: - ExploreInteractorDelegate
extension ExploreInteractor: ExploreInteractorDelegate {
    
    func getFlights(completion: @escaping ExploreGetFlightsCompletionBlock) {
        //__ TODO
        completion(FlightViewModel.getTestViewModel(), true, nil)
    }
    
}
