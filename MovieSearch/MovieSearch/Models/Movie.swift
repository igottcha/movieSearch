//
//  Movie.swift
//  MovieSearch
//
//  Created by Chris Gottfredson on 3/13/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import Foundation

struct TopLevelObject: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}
