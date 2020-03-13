//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Chris Gottfredson on 3/13/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, MovieTableViewCellDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MovieController.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = MovieController.movies[indexPath.row]
        
        cell.fetchImage(movie: movie)
        cell.titleLabel.text = movie.title
        cell.fetchMPAARating(movie: movie)
        cell.overviewLabel.text = movie.overview
        cell.delegate = self
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }

}

extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased(), !searchTerm.isEmpty else { return }
        MovieController.fetchMovies(searchItem: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.tableView.reloadData()
                case .failure(let error):
                    print("\(searchTerm) did not provide result. \(error.localizedDescription)")
                }
            }
        }
    }
}
