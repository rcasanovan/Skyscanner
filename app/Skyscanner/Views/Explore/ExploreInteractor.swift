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
    private var pollEndPoint: String?
    private var pageIndex: UInt
    private var pageSize: UInt
    private var allFlightsSync: Bool = false
    private var flightsViewModel: [FlightViewModel]
    
    init() {
        pageIndex = 0
        pageSize = 1000
        flightsViewModel = []
        pollEndPoint = SessionManager.shared.getPollEndpoint()
    }
    
}

// MARK: - Private section
extension ExploreInteractor {
    
    private func getFlightsWith(pollEndpoint: String, pageIndex: UInt, pageSize: UInt, simulatedJSONFile: String? = nil, completion: @escaping getFlightsCompletionBlock) {
        var pollRequest = PollRequest(pollEndpoint: pollEndpoint, pageIndex: pageIndex, pageSize: pageSize)
        
        pollRequest.completion = completion
        pollRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: pollRequest)
    }
    
    private func createSessionWith(body: CreateSessionParameterData, completion: @escaping createSessionCompletionBlock) {
        var sessionRequest = SessionRequest()
        
        sessionRequest.completion = completion
        sessionRequest.encodableBody = body
        requestManager.send(request: sessionRequest)
    }
    
}

// MARK: - ExploreInteractorDelegate
extension ExploreInteractor: ExploreInteractorDelegate {
    
    func clear() {
        pageIndex = 0
        allFlightsSync = false
        flightsViewModel = []
    }
    
    func isSessionCreated() -> Bool {
        return SessionManager.shared.isSessionCreated()
    }
    
    func createSession(completion: @escaping ExploreCreateSessionCompletionBlock) {
        let nextMondayFromToday = Date.today().next(.monday).getStringyyyyMMddFormat()
        let nextTuesdayFromToday = Date.today().next(.tuesday).getStringyyyyMMddFormat()
        let body = CreateSessionParameterData(cabinclass: "Economy", country: "UK", currency: "GBP", locale: "en-GB", locationSchema: "sky", originplace: "EDI-sky", destinationplace: "LOND-sky", outbounddate: nextMondayFromToday, inbounddate: nextTuesdayFromToday, adults: 1, children: 0, infants: 0, apikey: "ss630745725358065467897349852985")
        
        createSessionWith(body: body) { [weak self] (response) in
            guard let `self` = self else { return }
            switch response {
            case .success(let sessionResponse):
                if let sessionResponse = sessionResponse {
                    SessionManager.shared.addValue(sessionResponse.Location, forKey: Fields.pollEndpoint)
                }
                self.pollEndPoint = sessionResponse?.Location
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func getFlights(completion: @escaping ExploreGetFlightsCompletionBlock) {
        guard let pollEndPoint = pollEndPoint else {
            completion(nil, false, nil, allFlightsSync)
            return
        }
        
        if allFlightsSync {
            completion(self.flightsViewModel, true, nil, allFlightsSync)
            return
        }
        
        getFlightsWith(pollEndpoint: pollEndPoint, pageIndex: pageIndex, pageSize: pageSize) { [weak self] (response) in
            guard let `self` = self else { return }
            switch response {
            case .success(let pollResponse):
                guard let pollResponse = pollResponse else {
                    completion(nil, false, nil, self.allFlightsSync)
                    return
                }
                self.pageIndex = self.pageIndex + 1
                let responseViewModel = FlightViewModel.getViewModelWith(pollResponse: pollResponse)
                if responseViewModel.count == 0 {
                    self.allFlightsSync = true
                }
                self.flightsViewModel.append(contentsOf: responseViewModel)
                completion(self.flightsViewModel, true, nil, self.allFlightsSync)
            case .failure(let error):
                if let httpCode = error.httpCode, httpCode.isSessionError {
                    SessionManager.shared.clearSession()
                    self.clear()
                }
                
                completion(nil, false, error, self.allFlightsSync)
            }
        }
    }
    
    func getDateRange() -> (outbounddate: Date , inbounddate: Date) {
        return (Date.today().next(.monday), Date.today().next(.tuesday))
    }
    
    func getStations() -> (originStation: String, destinationStation: String) {
        return ("Edinburgh", "London")
    }
    
}
