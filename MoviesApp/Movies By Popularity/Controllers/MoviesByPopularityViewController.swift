//
//  MoviesByPopularityViewController.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import UIKit

class MoviesByPopularityViewController: UIViewController {
    @IBOutlet weak var moviesByPopularityTableView: UITableView!
    
    private var viewModel: MoviesByPopularityViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.moviesByPopularityTableView.dataSource = self
        self.moviesByPopularityTableView.delegate = self
        self.viewModel = MoviesByPopularityViewModel(subscriber: self)
        self.start()
    }
    
    func start() {
        self.viewModel.loadFirstPage()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckMovieSegue" {
            if let destinationVC = segue.destination as? MovieDetailsViewController {
                if let movie = sender as? MoviesAPIMovieModel {
                    destinationVC.viewModel = MovieDetailsViewModel(movie: movie, subscriber: destinationVC)
                    destinationVC.setViewContent()
                }
            }
        }
    }

}

extension MoviesByPopularityViewController {
    func handlePageLoadedNotification(for page: Int, wasSuccess: Bool) {
        DispatchQueue.main.async {
            self.moviesByPopularityTableView.reloadData()
        }
    }
}

extension MoviesByPopularityViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.viewModel.getMoviesCount()
        case 1:
            
            if self.viewModel.allPagesLoaded() {
                return 0
            }else {
                return 1
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MoviesTableViewCell else {
                return UITableViewCell()
            }
            
            cell.viewModel = MovieDetailsViewModel(movie: self.viewModel.getMovieDetailsViewModel(forRow: indexPath.row)!, subscriber: cell)
            cell.setCellLabelsElement()
            cell.setCellImageElement()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell") as? LoadingMoviesTableViewCell else {
                return UITableViewCell()
            }
            cell.spinner.startAnimating()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.viewModel.getMovieDetailsViewModel(forRow: indexPath.row)
        self.performSegue(withIdentifier: "CheckMovieSegue", sender: movie)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            self.viewModel.loadNextPage()
        }
    }
}
