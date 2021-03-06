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
        
        let allLegs = pollResponse.Legs
        let allCarriers = pollResponse.Carriers
        let allPlaces = pollResponse.Places
        let allAgents = pollResponse.Agents
        guard let currency = pollResponse.Currencies.first else {
            return flights
        }
        
        for eachItinerary in pollResponse.Itineraries {
            if let outboundInformation = boundInformationWith(outbound: true, itinerary: eachItinerary, allLegs: allLegs, allCarriers: allCarriers, allPlaces: allPlaces), let inboundInformation = boundInformationWith(outbound: false, itinerary: eachItinerary, allLegs: allLegs, allCarriers: allCarriers, allPlaces: allPlaces) {
                for eachPrice in eachItinerary.PricingOptions {
                    let rating = getRating()
                    let information = getInformation()
                    let bookingInformation = getBookingInformationWithPricing(eachPrice, allAgents: allAgents)
                    let price = currency.SymbolOnLeft ? "\(currency.Symbol) \(eachPrice.Price)" : "\(eachPrice.Price) \(currency.Symbol)"
                    let flightViewModel = FlightViewModel(outboundInformation: outboundInformation, inboundInformation: inboundInformation, price: price, bookingInformation: bookingInformation, rating: rating, information: information)
                    flights.append(flightViewModel)
                }
            }
        }
        
        return flights
    }

}

extension FlightViewModel {
    
    private static func boundInformationWith(outbound: Bool, itinerary: ItineraryResponse, allLegs: [LegResponse], allCarriers: [CarrierResponse], allPlaces: [PlaceResponse]) -> FlightInformationViewModel? {
        var leg: LegResponse?
            
        if outbound {
            leg = allLegs.filter {$0.Id == itinerary.OutboundLegId}.first
        } else {
            leg = allLegs.filter {$0.Id == itinerary.InboundLegId}.first
        }
        
        guard let currentLeg = leg, let currentCarrierId = currentLeg.Carriers.first else {
            return nil
        }
        
        let carrier = allCarriers.filter {$0.Id == currentCarrierId}.first
        guard let currentCarrier = carrier else {
            return nil
        }
        
        guard let departureHHmmTime = Date.getISODateWithString(currentLeg.Departure)?.getStringHHmmFormat(), let arrivalHHmmTime = Date.getISODateWithString(currentLeg.Arrival)?.getStringHHmmFormat() else {
            return nil
        }
        
        let originStation = allPlaces.filter {$0.Id == currentLeg.OriginStation}.first
        let destinationStation = allPlaces.filter {$0.Id == currentLeg.DestinationStation}.first
        guard let currentOriginStation = originStation, let currentDestinationStation = destinationStation else {
            return nil
        }
        
        let airlineUrl = URL(string: "https://logos.skyscnr.com/images/airlines/favicon/\(currentCarrier.Code).png")
        
        let totalStops = currentLeg.Stops.count
        let connection = totalStops > 0 ? "\(totalStops) scale" : "Direct"
        
        let information = "\(currentOriginStation.Code)-\(currentDestinationStation.Code), \(currentCarrier.Name)"
        
        let time = "\(departureHHmmTime) - \(arrivalHHmmTime)"
        
        let timeDuration = Date.minutesToHoursMinutes(minutes: currentLeg.Duration)
        let duration = "\(timeDuration.hours)h \(timeDuration.leftMinutes)m"
        
        return FlightInformationViewModel(airlineUrl: airlineUrl, time: time, information: information, connection: connection, duration: duration)
    }
    
    private static func getRating() -> String {
        return String(format: "%.2f", Float.random(in: 1.0 ... 10.0))
    }
    
    private static func getInformation() -> String {
        let bookingInformation = ["Cheapest", "Shorter", "Cheapest Shortest", ""]
        guard let random = bookingInformation.randomElement() else {
            return ""
        }
        
        return random
    }
    
    private static func getBookingInformationWithPricing(_ pricing: PricingOptionResponse,  allAgents: [AgentResponse]) -> String {
        
        if pricing.Agents.count > 1 {
            return "\(pricing.Agents.count) required"
        }
        
        guard let agentId = pricing.Agents.first else {
            return ""
        }
        
        let agent = allAgents.filter {$0.Id == agentId}.first
        guard let currentAgent = agent else {
            return ""
        }
        
        return "with \(currentAgent.Name)"
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
