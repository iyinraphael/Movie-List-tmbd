//
//  APIService.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/5/23.
//

import Foundation
import Combine

protocol APIService: NetworkService {
    /**
     Gets All available movie genres
     - Returns: A publisher that will return MovieGenre
     */
    func getGenres() -> AnyPublisher<MovieGenre, APIServiceError>

    

}
