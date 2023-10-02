//
//  Endpoint.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

//TODO: Body parameters if needed
protocol Endpoint {
    
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    
    var scheme: String {
        return "https"
    }
}
