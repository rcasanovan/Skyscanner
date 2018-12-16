//
//  NetworkTests.swift
//  SkyscannerTests
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import XCTest
@testable import Skyscanner

typealias createSessionCompletionBlock = (Result<CreateSessionResponse?>) -> Void
typealias pollCompletionBlock = (Result<PollResponse?>) -> Void

class NetworkTests: XCTestCase {
    
    private let requestManager = RequestManager()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCreateSessionWith(body: CreateSessionParameterData, completion: @escaping createSessionCompletionBlock) {
        var sessionRequest = SessionRequest()
        
        sessionRequest.completion = completion
        sessionRequest.encodableBody = body
        sessionRequest.verbose = true
        requestManager.send(request: sessionRequest)
    }
    
    func testPollResultsWith(pollEndpoint: String, pageIndex: UInt, pageSize: UInt, simulatedJSONFile: String? = nil,  completion: @escaping pollCompletionBlock) {
        var pollRequest = PollRequest(pollEndpoint: pollEndpoint, pageIndex: pageIndex, pageSize: pageSize)
        
        pollRequest.completion = completion
        pollRequest.simulatedResponseJSONFile = simulatedJSONFile
        pollRequest.verbose = true
        requestManager.send(request: pollRequest)
    }
    
    func testCreateSession() {
        let sessionExpectation: XCTestExpectation = self.expectation(description: "sessionExpectation")
        
        let nextMondayFromToday = Date.today().next(.monday).getStringyyyyMMddFormat()
        let nextTuesdayFromToday = Date.today().next(.monday).add(days: 1).getStringyyyyMMddFormat()
        let body = CreateSessionParameterData(cabinclass: "Economy", country: "UK", currency: "GBP", locale: "en-GB", locationSchema: "sky", originplace: "EDI-sky", destinationplace: "LOND-sky", outbounddate: nextMondayFromToday, inbounddate: nextTuesdayFromToday, adults: 1, children: 0, infants: 0, apikey: "ss630745725358065467897349852985")
        
        testCreateSessionWith(body: body) { (response) in
            switch response {
            case .success(let sessionResponse):
                XCTAssertTrue(sessionResponse != nil, "Impossible to get the session response")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            sessionExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testPollResultsWith(pollEndpoint: String, expectation: XCTestExpectation, simulatedJSONFile: String? = nil) {
        testPollResultsWith(pollEndpoint: pollEndpoint, pageIndex: 0, pageSize: 10, simulatedJSONFile: simulatedJSONFile) { (response) in
            switch response {
            case .success(let pollResponse):
                XCTAssertTrue(pollResponse != nil, "Impossible to get the poll response")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
    }
    
    func testPollResults() {
        let pollResultsExpectation: XCTestExpectation = self.expectation(description: "pollResultsExpectation")
        
        let nextMondayFromToday = Date.today().next(.monday).getStringyyyyMMddFormat()
        let nextTuesdayFromToday = Date.today().next(.monday).add(days: 1).getStringyyyyMMddFormat()
        let body = CreateSessionParameterData(cabinclass: "Economy", country: "UK", currency: "GBP", locale: "en-GB", locationSchema: "sky", originplace: "EDI-sky", destinationplace: "LOND-sky", outbounddate: nextMondayFromToday, inbounddate: nextTuesdayFromToday, adults: 1, children: 0, infants: 0, apikey: "ss630745725358065467897349852985")
        
        testCreateSessionWith(body: body) { (response) in
            switch response {
            case .success(let sessionResponse):
                guard let sessionResponse = sessionResponse else {
                    XCTFail("Impossible to get the session response")
                    return
                }
                self.testPollResultsWith(pollEndpoint: sessionResponse.Location, expectation: pollResultsExpectation)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }            
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testSimulatedPollResults() {
        let pollResultsExpectation: XCTestExpectation = self.expectation(description: "pollResultsExpectation")
        
        let nextMondayFromToday = Date.today().next(.monday).getStringyyyyMMddFormat()
        let nextTuesdayFromToday = Date.today().next(.monday).add(days: 1).getStringyyyyMMddFormat()
        let body = CreateSessionParameterData(cabinclass: "Economy", country: "UK", currency: "GBP", locale: "en-GB", locationSchema: "sky", originplace: "EDI-sky", destinationplace: "LOND-sky", outbounddate: nextMondayFromToday, inbounddate: nextTuesdayFromToday, adults: 1, children: 0, infants: 0, apikey: "ss630745725358065467897349852985")
        
        testCreateSessionWith(body: body) { (response) in
            switch response {
            case .success(let sessionResponse):
                guard let sessionResponse = sessionResponse else {
                    XCTFail("Impossible to get the session response")
                    return
                }
                self.testPollResultsWith(pollEndpoint: sessionResponse.Location, expectation: pollResultsExpectation, simulatedJSONFile: "SimulatedResponse")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }

}
