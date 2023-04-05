//
//  MovieGenre.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/4/23.
//

import Foundation


struct MovieGenre: Codable {

    // MARK: - Properties

    let genres: [Genre]
}

struct Genre: Codable {

    // MARK: - Properties

    let id: Int
    let name: String


    // MARK: - Type

    enum GenreType {

        case action
        case adventure
        case animation
        case comedy
        case crime
        case documentary
        case drama
        case family
        case fantasy
        case history
        case horror
        case music
        case mystery
        case romance
        case sciFiction
        case tvMovie
        case thriller
        case war
        case western


        var genreType: String {
            switch self {
            case .action:
                return "Action"
            case .adventure:
                return "Adventure"
            case .animation:
                return "Animation"
            case .comedy:
                return "Comedy"
            case .crime:
                return "Crime"
            case .documentary:
                return "Documentary"
            case .drama:
                return "Drama"
            case .family:
                return "Family"
            case .fantasy:
                return "Fantasy"
            case .history:
                return "History"
            case .horror:
                return "Horror"
            case .music:
                return "Music"
            case .mystery:
                return "Mystery"
            case .romance:
                return "Romance"
            case .sciFiction:
                return "Science Fiction"
            case .tvMovie:
                return "TV Movie"
            case .thriller:
                return "Thriller"
            case .war:
                return "War"
            case .western:
                return "Western"
            }
        }

        var genreId: Int {
            switch self {
            case .action:
                return 28
            case .adventure:
                return 12
            case .animation:
                return 16
            case .comedy:
                return 35
            case .crime:
                return 80
            case .documentary:
                return 99
            case .drama:
                return 18
            case .family:
                return 10751
            case .fantasy:
                return 14
            case .history:
                return 36
            case .horror:
                return 27
            case .music:
                return 10402
            case .mystery:
                return 9648
            case .romance:
                return 10749
            case .sciFiction:
                return 878
            case .tvMovie:
                return 10770
            case .thriller:
                return 53
            case .war:
                return 10752
            case .western:
                return 37
            }
        }
    }
}
