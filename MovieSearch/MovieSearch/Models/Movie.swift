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
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case overview
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}
