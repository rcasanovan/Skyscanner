//
//  FlightsDataSource.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 13/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class FlightsDatasource: NSObject {
    
    public var flights: [FlightViewModel]
    
    public override init() {
        flights = [FlightViewModel]()
        super.init()
    }
    
}

extension FlightsDatasource {
    
    private func generateFlightCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightTableViewCell.identifier, for: indexPath) as? FlightTableViewCell else {
            return UITableViewCell()
        }
        
        //__ Bind the cell
        let viewModel = flights[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
    
}

// MARK: - UITableViewDataSource
extension FlightsDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return generateFlightCell(tableView, cellForRowAt: indexPath)
    }
    
}
