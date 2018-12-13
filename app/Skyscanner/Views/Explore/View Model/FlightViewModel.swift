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
        var flights: [FlightViewModel] = [FlightViewModel]()
        
        for eachItinerary in pollResponse.Itineraries {
            let airlineUrl = URL(string: "https://logos.skyscnr.com/images/airlines/favicon/EZ.png")
            let outboundInformation =  FlightInformationViewModel(airlineUrl: airlineUrl, time: "15:35 - 17:00", information: "BUD-LGW, Wizz Air", connection: "Direct", duration: "2h 35m")
            let inboundInformation =  FlightInformationViewModel(airlineUrl: airlineUrl, time: "15:35 - 17:00", information: "BUD-LGW, Wizz Air", connection: "Direct", duration: "2h 35m")
            
            for eachPrice in eachItinerary.PricingOptions {
                let price = "\(eachPrice.Price)€"
                let flightViewModel = FlightViewModel(outboundInformation: outboundInformation, inboundInformation: inboundInformation, price: price, bookingInformation: "2 bookings required", rating: "10.0", information: "Cheapest Shortest")
                flights.append(flightViewModel)
            }
        }
        
        return flights
    }

}

extension FlightViewModel {
    
    public static func getTestViewModel() -> [FlightViewModel] {
        var flights: [FlightViewModel] = [FlightViewModel]()
        let airlineUrl = URL(string: "https://logos.skyscnr.com/images/airlines/favicon/EZ.png")
        
        let outboundInformation =  FlightInformationViewModel(airlineUrl: airlineUrl, time: "15:35 - 17:00", information: "BUD-LGW, Wizz Air", connection: "Direct", duration: "2h 35m")
        let inboundInformation =  FlightInformationViewModel(airlineUrl: airlineUrl, time: "15:35 - 17:00", information: "BUD-LGW, Wizz Air", connection: "Direct", duration: "2h 35m")
        
        let flightViewModel = FlightViewModel(outboundInformation: outboundInformation, inboundInformation: inboundInformation, price: "80€", bookingInformation: "2 bookings required", rating: "10.0", information: "Cheapest Shortest")
        
        for _ in 1...10 {
            flights.append(flightViewModel)
        }
        
        return flights
    }
    
}
