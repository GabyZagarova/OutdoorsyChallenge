//
//  HTTPClient.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

protocol HTTPClientProtocol {
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModelType: T.Type) async throws -> T
}

final class HTTPClient: HTTPClientProtocol {
    // TODO: If the API requires authorisation, extend session functionality - add authorised session
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModelType: T.Type) async throws -> T {

        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
      
        guard let url = urlComponents.url else {
            throw NetworkingError.invalidRequestError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        #warning("Development - Simulate location in San Francisco")
        request.setValue("203.0.113.195, 70.41.3.18, 150.172.238.178", forHTTPHeaderField: "X-Forwarded-For")

        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkingError.invalidResponse
            }
            
            switch response.statusCode {
            case 200 ... 299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModelType, from: data)
                    return decodedResponse
                } catch {
                    throw NetworkingError.decodingError
                }
            case 401:
                throw NetworkingError.unauthorised
            default:
                throw NetworkingError.invalidResponse
            }
        } catch {
            throw NetworkingError.generic
        }
    }
}
