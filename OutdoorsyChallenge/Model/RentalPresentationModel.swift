//
//  RentalPresentationModel.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

struct Rental {
    
    let id: String
    let name: String
    let description: String
    let displayVehicleType: String
    let imageURL: URL?
    let unavailable: Bool
}

extension Rental {
    
    init(rentalDTO: RentalsService.RentalDTO) {
        self.init(
            id: rentalDTO.id,
            name: rentalDTO.name,
            description: rentalDTO.description,
            displayVehicleType: rentalDTO.displayVehicleType,
            imageURL: URL(string: rentalDTO.imageURLString),
            unavailable: rentalDTO.unavailable)
    }
}
