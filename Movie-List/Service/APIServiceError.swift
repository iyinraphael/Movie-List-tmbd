//
//  APIServiceError.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/5/23.
//

import Foundation

enum APIServiceError: Error {

    // MARK: - Error types

    case decodeFailure
    case networkFailure
    case generalFailure
}
