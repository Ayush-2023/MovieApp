//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 01/01/24.
//

import UIKit

class MovieDetailsViewController: UIViewController, MovieDetailsViewModelObserver {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieReleaseDatePromtLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingPromtLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var moviePopularityPromtLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    @IBOutlet weak var movieOverviewPromtLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    var viewModel: MovieDetailsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.movieReleaseDatePromtLabel.font = UIFont(name: "ArialMT", size: 14)
        self.movieReleaseDatePromtLabel.textColor = .gray
        self.movieReleaseDatePromtLabel.text = "Release Date"
        self.movieReleaseDateLabel.font = UIFont(name: "ArialMT", size: 14)
        self.movieReleaseDateLabel.textColor = .gray.withAlphaComponent(0.7)
        
        self.movieRatingPromtLabel.font = UIFont(name: "ArialMT", size: 14)
        self.movieRatingPromtLabel.textColor = .gray
        self.movieRatingPromtLabel.text = "⭐️ Rating"
        self.movieRatingLabel.font = UIFont(name: "ArialMT", size: 14)
        self.movieRatingLabel.textColor = .gray.withAlphaComponent(0.7)
        
        self.moviePopularityPromtLabel.font = UIFont(name: "ArialMT", size: 14)
        self.moviePopularityPromtLabel.textColor = .gray
        self.moviePopularityPromtLabel.text = "❤️Popularity"
        self.moviePopularityLabel.font = UIFont(name: "ArialMT", size: 14)
        self.moviePopularityLabel.textColor = .gray.withAlphaComponent(0.7)
        
        self.movieOverviewPromtLabel.font = UIFont(name: "Arial-BoldMT", size: 18)
        self.movieOverviewPromtLabel.textColor = .gray
        self.movieOverviewPromtLabel.text = "Overview"
        self.movieOverviewLabel.font = UIFont(name: "ArialMT", size: 14)
        self.movieOverviewLabel.textColor = .gray.withAlphaComponent(0.7)
        self.moviePosterImageView.layer.cornerRadius = 20
    }
    
    func setViewContent(){
        guard let viewModel else {
            return
        }
        DispatchQueue.main.async {
            self.title = viewModel.getMovieTitle()
            self.movieReleaseDateLabel.text = viewModel.getMovieReleaseDate()
            self.movieRatingLabel.text = viewModel.getMovieRating()
            self.moviePopularityLabel.text = viewModel.getMoviePopularity()
            self.movieOverviewLabel.text = viewModel.getMovieOverview()
            
            self.moviePosterImageView.image = UIImage(systemName: "photo")
            viewModel.loadMoviePoster()
        }
    }
    
    func handlePosterLoadedNotification(wasSuccess: Bool) {
        guard let poster = self.viewModel?.getMoviePoster() else {
            return
        }
        DispatchQueue.main.async {
            self.moviePosterImageView.image = poster
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
