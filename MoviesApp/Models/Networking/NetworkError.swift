//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case invalidData
    case otherError(description: String)
}
