//
//  Movie.swift
//  Movie-List
//
//  Created by Iyin Raphael on 4/5/23.
//

import Foundation

struct Movie: Codable {

    // MARK: - Properties

    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    let genreIds: [Int]
}
