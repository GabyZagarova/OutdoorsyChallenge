//
//  RentalsEndpoint.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

struct RentalsEndpoint: Endpoint {
    
    //TODO: property wrapper array to space string
    
    /// Required -> space-separated string of search terms
    var filterKeywords: [String]
    
    /// Example: a "third page" of 8 results would have limit of 8, offset of 16
    /// Optional -> an integer that sets requested maximum result count
    var pageLimit: UInt
    /// Optional -> an integer that sets the index of the first result
    var pageOffset: UInt = 0
    
    //TODO: this could be split domain(outdoorsy.com) and and prefix (search) it depends on the other APIs structure
    var host: String {
        "search.outdoorsy.com"
    }
    
    var path: String {
        "/rentals"
    }
    
    var method: RequestMethod {
        .get
    }
        
    var queryItems: [URLQueryItem]? {
        var queryItems = [URLQueryItem]()
        let keysFormattedString = filterKeywords.joined(separator: " ")
        queryItems.append(URLQueryItem(name: "filter[keywords]", value: keysFormattedString))
        queryItems.append(URLQueryItem(name: "page[limit]", value: "\(pageLimit)"))
        queryItems.append(URLQueryItem(name: "page[offset]", value: "\(pageOffset)"))
        return queryItems
    }
}
