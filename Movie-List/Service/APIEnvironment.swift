//
//  APIEnvironment.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/6/23.
//

import Foundation


public struct APIEnvironment {

    // MARK: Private properties
    private let APIKey = "e202e696bf07ade85569aa1904a4deb5"

    // MARK: - public Properties
    public var movieURL: MoviesURL

    public enum MoviesURL {
        case topRated
        case popular
        case nowPlaying

        var baseURL: String {
            switch self {
            case .topRated:
                return "https://api.themoviedb.org/3/movie/top_rated"
            case .popular:
                return "/movie/popular"
            case .nowPlaying:
                return "/movie/now_playing"
            }
        }
    }

    // MARK: - Public Methods

    func apiKey() -> String {
        return self.APIKey
    }
}
