//
//  ReleaseDates.swift
//  MovieSearch
//
//  Created by Chris Gottfredson on 3/13/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import Foundation

struct ReleaseDateSearchResults: Codable {
    let movieId: Int
    let results: [Location]
    
    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case results
    }
}

struct Location: Codable {
    let countryCode: String
    let releaseDates: [ReleaseDate]
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "iso_3166_1"
        case releaseDates = "release_dates"
    }
}

struct ReleaseDate: Codable {
    let mpaaRating: String
    let releaseDate: String
    let releaseType: Int
    
//    enum ReleaseType: Int, CodingKey {
//        case premiere = 1
//        case theatrical = 2
//        case theatricalLimited = 3
//        case digital = 4
//        case physical = 5
//        case tV = 6
//    }
    
    enum CodingKeys: String, CodingKey {
        case mpaaRating = "certification"
        case releaseDate = "release_date"
        case releaseType = "type"
    }
}
