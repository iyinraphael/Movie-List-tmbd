//
//  Movie.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/5/23.
//

import Foundation

struct Movie: Codable, Hashable {

    // MARK: - Properties

    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    let genreIds: [Int]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
    }
}
