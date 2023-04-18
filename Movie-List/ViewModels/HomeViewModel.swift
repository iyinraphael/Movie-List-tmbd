//
//  HomeViewModel.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/11/23.
//

import Foundation
import Combine

class HomeViewModel {

    // MARK: - 
    var topRatedMoviesPublisher: AnyPublisher<[Movie], APIServiceError> {
        return apiService.getMovies(for: .topRated)
    }
    var popularMoviesPublisher: AnyPublisher<[Movie], APIServiceError> {
        return apiService.getMovies(for: .popular)
    }
    var nowPlayingMoviesPublisher: AnyPublisher<[Movie], APIServiceError> {
        return apiService.getMovies(for: .nowPlaying)
    }

    let apiService: MovieAPIService

    init(apiService: MovieAPIService) {
        self.apiService = apiService
    }
}
