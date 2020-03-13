//
//  MovieController.swift
//  MovieSearch
//
//  Created by Chris Gottfredson on 3/13/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class MovieController {
    
    //MARK: - Properties

    static var movies: [Movie] = []
    
    private static let baseURL = URL(string: "https://api.themoviedb.org/3")
    private static let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")
    private static let searchEndpoint = "search"
    private static let movieEndpoint = "movie"
    private static let api_Key = "77067d8899800d1a6a1e48b3b0fa1854"
    private static let languageName = "language"
    private static let englishUSLanguageValue = "en-US"
    private static let queryName = "query"
    private static let adultName = "adult"
    private static let adultValue = "false"
    private static let releaseDatesEndpoint = "release_dates"
    
    static func fetchMovies(searchItem: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let searchURL = baseURL.appendingPathComponent(searchEndpoint).appendingPathComponent(movieEndpoint)
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: api_Key), URLQueryItem(name: languageName, value: englishUSLanguageValue), URLQueryItem(name: queryName, value: searchItem), URLQueryItem(name: adultName, value: adultValue)]
        
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelOjbect = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let movies = topLevelOjbect.results
                self.movies = movies
                return completion(.success(movies))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
        }.resume()
    }
    
    static func fetchImage(posterPath: String?, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        guard let baseImageURL = baseImageURL, let posterPath = posterPath else { return completion(.failure(.invalidURL))}
        let imageURL = baseImageURL.appendingPathComponent(posterPath)
        print(imageURL)
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            guard let image = UIImage(data: data) else { return completion(.failure(.noData))}
            return completion(.success(image))
        }.resume()
    }
    
    static func fetchMPAARating(id: Int, completion: @escaping (Result<String, MovieError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let releaseDateURL = baseURL.appendingPathComponent(movieEndpoint).appendingPathComponent(String(id))
        var urlComponents = URLComponents(url: releaseDateURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "api_Key", value: api_Key)]
        
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelOjbect = try JSONDecoder().decode(ReleaseDateSearchResults.self, from: data)
                let releaseLocations = topLevelOjbect.results
                let usReleaseLocations = releaseLocations.filter { $0.countryCode == "US"}
                guard let releaseDates = usReleaseLocations.first?.releaseDates else { return completion(.failure(.unableToDecode))}
                print(releaseDates)
                guard let mpaaRating = releaseDates.first?.mpaaRating else { return completion(.failure(.unableToDecode))}
                print(mpaaRating)
                return completion(.success(mpaaRating))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
}
