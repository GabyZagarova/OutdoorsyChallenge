//
//  StringToWords.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import Foundation

extension String {
    
    func toWords() -> [String] {
        guard self != "",
              self != " " else {
            return []
        }
        return self
            .split(separator: " ", omittingEmptySubsequences: true)
            .map( { String($0) })
    }
}
