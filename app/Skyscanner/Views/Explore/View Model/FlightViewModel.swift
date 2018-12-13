//
//  FlightViewModel.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

struct FlightInformationViewModel {
    let airlineUrl: URL?
    let time: String
    let information: String
    let connection: String
    let duration: String
    
    init(airlineUrl: URL?, time: String, information: String, connection: String, duration: String) {
        self.airlineUrl = airlineUrl
        self.time = time
        self.information = information
        self.connection = connection
        self.duration = duration
    }
}

struct FlightViewModel {
    let outboundInformation: FlightInformationViewModel
    let inboundInformation: FlightInformationViewModel
    let price: String
    let bookingInformation: String
    let rating: String
    let information: String
    
    init(outboundInformation: FlightInformationViewModel, inboundInformation: FlightInformationViewModel, price: String, bookingInformation: String, rating: String, information: String) {
        self.outboundInformation = outboundInformation
        self.inboundInformation = inboundInformation
        self.price = price
        self.bookingInformation = bookingInformation
        self.rating = rating
        self.information = information
    }
    
    public static func getViewModelWith(pollResponse: PollResponse) -> [FlightViewModel] {
        //__ TO DO
        return [FlightViewModel]()
    }
    
//    public static func getTestViewModel() -> HDSettingsViewModel {
//        return HDSettingsViewModel(imageUrl: "https://s3.amazonaws.com/hood-images/2222thumbnail", username: "Ricardo", age: 37)
//    }
}

extension FlightViewModel {
    
    public static func getTestViewModel() -> [FlightViewModel] {
        var flights: [FlightViewModel] = [FlightViewModel]()
        
        let outboundInformation =  FlightInformationViewModel(airlineUrl: nil, time: "15:35 - 17:00", information: "BUD-LGW, Wizz Air", connection: "Direct", duration: "2h 35m")
        let inboundInformation =  FlightInformationViewModel(airlineUrl: nil, time: "15:35 - 17:00", information: "BUD-LGW, Wizz Air", connection: "Direct", duration: "2h 35m")
        
        let flightViewModel = FlightViewModel(outboundInformation: outboundInformation, inboundInformation: inboundInformation, price: "80€", bookingInformation: "2 bookings required", rating: "10.0", information: "Cheapest Shortest")
        
        for _ in 1...10 {
            flights.append(flightViewModel)
        }
        
        return flights
    }
    
}
