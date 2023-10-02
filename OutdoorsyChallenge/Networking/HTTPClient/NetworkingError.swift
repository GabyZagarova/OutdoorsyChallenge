//
//  NetworkingError.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

//TODO: Capture error for example decoding errors
//TODO: Add extension - with user readable messages
//TODO: In debug return, print, print log the actual error message

enum NetworkingError: Error, Equatable {
    /// Invalid request, e.g. invalid URL
    case invalidRequestError(String)
    /// Received an invalid response, e.g. invalid result type
    case invalidResponse
    /// The server sent data in an unexpected format
    case decodingError
    /// Missing or invalid authorisation token
    case unauthorised
    /// Generic error
    case generic
}
