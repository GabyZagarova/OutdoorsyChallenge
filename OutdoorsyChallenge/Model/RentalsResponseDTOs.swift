//
//  RentalsResponseDTOs.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

extension RentalsService {
    
    struct RentalsResponseRootDTO {
        let rentals: [RentalDTO]
        let totalCount: UInt
    }

    struct RentalDTO {
        let id: String
        let name: String
        let description: String
        let displayVehicleType: String
        let imageURLString: String
        // TODO: Maybe the mobile app should display only available rentals
        let unavailable: Bool
    }
}

extension RentalsService.RentalsResponseRootDTO: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case rentals = "data"
        case meta = "meta"
    }
    
    private enum MetaCodingKeys: String, CodingKey {
        case totalCount = "total"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RentalsService.RentalsResponseRootDTO.RootCodingKeys.self)
        rentals = try container.decode([RentalsService.RentalDTO].self, forKey: .rentals)

        let metaContainer = try container.nestedContainer(keyedBy: RentalsService.RentalsResponseRootDTO.MetaCodingKeys.self, forKey: .meta)
        totalCount = try metaContainer.decode(UInt.self, forKey: .totalCount)
    }
}

extension RentalsService.RentalDTO: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case id = "id"
        case attributes = "attributes"
    }
    
    private enum AttributesCodingKeys: String, CodingKey {
        case name = "name"
        case description = "description_other"
        case displayVehicleType = "display_vehicle_type"
        case imageURLString = "primary_image_url"
        case unavailable = "unavailable"
    }
    
    init(from decoder: Decoder) throws {
        // TODO: Handle scenario where some of the keys might be missing?
        let container = try decoder.container(keyedBy: RentalsService.RentalDTO.RootCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        // Nested keys
        let attributesContainer = try container.nestedContainer(keyedBy: RentalsService.RentalDTO.AttributesCodingKeys.self, forKey: .attributes)
        name = try attributesContainer.decode(String.self, forKey: .name)
        description = try attributesContainer.decode(String.self, forKey: .description)
        displayVehicleType = try attributesContainer.decode(String.self, forKey: .displayVehicleType)
        imageURLString = try attributesContainer.decode(String.self, forKey: .imageURLString)
        unavailable = try attributesContainer.decode(Bool.self, forKey: .unavailable)
    }
}
