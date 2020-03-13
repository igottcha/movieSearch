//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Chris Gottfredson on 3/13/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

protocol MovieTableViewCellDelegate {
    
}

class MovieTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    //MARK: - Properties
    
    var delegate: MovieTableViewCellDelegate?
    
    //MARK: - Methods

    func fetchImage(movie: Movie) {
        MovieController.fetchImage(posterPath: movie.posterPath) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.posterImageView.image = image
                case .failure(let error):
                    print("Unable to fetch image for \(movie.title)\n\(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchMPAARating(movie: Movie) {
        MovieController.fetchMPAARating(id: movie.id) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let rating):
                    self.mpaaRatingLabel.text = rating
                case .failure(let error):
                    print("Unable to fetch MPAA Rating for \(movie.title)\n\(error.localizedDescription)")
                }
            }
        }
    }
}
