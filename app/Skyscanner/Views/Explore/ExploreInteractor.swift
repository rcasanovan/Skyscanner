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
    
    init() {
        pageIndex = 0
        pageSize = 20
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
    
    func isSessionCreated() -> Bool {
        //__ TODO
        return false
    }
    
    func createSession(completion: @escaping ExploreCreateSessionCompletionBlock) {
        let nextMondayFromToday = Date.today().next(.monday).getStringyyyyMMddFormat()
        let nextTuesdayFromToday = Date.today().next(.tuesday).getStringyyyyMMddFormat()
        let body = CreateSessionParameterData(cabinclass: "Economy", country: "UK", currency: "GBP", locale: "en-GB", locationSchema: "sky", originplace: "EDI-sky", destinationplace: "LOND-sky", outbounddate: nextMondayFromToday, inbounddate: nextTuesdayFromToday, adults: 1, children: 0, infants: 0, apikey: "ss630745725358065467897349852985")
        
        createSessionWith(body: body) { [weak self] (response) in
            guard let `self` = self else { return }
            switch response {
            case .success(let sessionResponse):
                self.pollEndPoint = sessionResponse?.Location
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func getFlights(completion: @escaping ExploreGetFlightsCompletionBlock) {
//        completion(FlightViewModel.getTestViewModel(), true, nil)
        
        guard let pollEndPoint = pollEndPoint else {
            completion(nil, false, nil)
            return
        }
        
        getFlightsWith(pollEndpoint: pollEndPoint, pageIndex: pageIndex, pageSize: pageSize) { [weak self] (response) in
            guard let `self` = self else { return }
            switch response {
            case .success(let pollResponse):
                guard let pollResponse = pollResponse else {
                    completion(nil, false, nil)
                    return
                }
                self.pageIndex = self.pageIndex + 1
                completion(FlightViewModel.getViewModelWith(pollResponse: pollResponse), true, nil)
            case .failure(let error):
                completion(nil, false, error)
            }
        }
    }
    
}
