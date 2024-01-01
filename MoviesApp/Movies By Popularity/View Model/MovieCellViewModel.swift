//
//  MovieCellViewModel.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 01/01/24.
//

import Foundation
import UIKit

protocol MovieCellViewModelProtocol {
    func getMovieTitle() -> String
    func getMovieOverview() -> String
    func getMoviePoster() -> UIImage?
    func loadMoviePoster()
}

protocol MovieDetailsViewModelProtocol {
    func getMovieTitle() -> String
    func getMovieOverview() -> String
    func getMovieRating() -> String
    func getMoviePopularity() -> String
    func getMovieReleaseDate() -> String
    func getMoviePoster() -> UIImage?
    func loadMoviePoster()
}

protocol MovieDetailsViewModelObserver {
    func handlePosterLoadedNotification(wasSuccess: Bool)
}

class MovieDetailsViewModel: MovieCellViewModelProtocol, MovieDetailsViewModelProtocol {
    
    
    private var movie: MoviesAPIMovieModel
    private var moviePoster: UIImage?
    
    private var subscribedObserver: MovieDetailsViewModelObserver
    private var movieDBNetworkService: MovieDBNetworkService
    private var moviePosterCahe: MoviePosterCache
    
    init(movie: MoviesAPIMovieModel, subscriber: MovieDetailsViewModelObserver) {
        self.movie = movie
        self.movieDBNetworkService = .shared
        self.subscribedObserver = subscriber
        self.moviePosterCahe = .shared
    }
    
    func getMovieTitle() -> String {
        return movie.title ?? "Movie Title"
    }
    
    func getMovieOverview() -> String {
        return movie.overview ?? "Movie Overview"
    }
    
    func getMoviePoster() -> UIImage? {
        return self.moviePoster
    }
    
    func getMovieRating() -> String {
        return String(movie.vote_average ?? 0.0)
    }
    
    func getMoviePopularity() -> String {
        return String(movie.popularity ?? 0.0)
    }
    
    func getMovieReleaseDate() -> String {
        return movie.release_date ?? "Movie Release Date"
    }
    
    private func getMoviePosterImageFile() -> String? {
        return movie.poster_path
    }
    
    func loadMoviePoster() {
        
        guard let posterImageFile = self.getMoviePosterImageFile() else {
            return
        }
        
        if let poster = self.moviePosterCahe.getImage(for: posterImageFile) {
            self.moviePoster = poster
            self.notifyView(for: .success)
        }
        
        self.movieDBNetworkService.loadMoviePoster(using: posterImageFile) { image in
            guard let poster = image else {
                
                self.notifyView(for: .failure)
                return
            }
            self.moviePosterCahe.set(image: poster, for: posterImageFile)
            self.moviePoster = poster
            self.notifyView(for: .success)
        }
    }
    
    func notifyView(for imageLoadingStatus: DataLoadingStatus) {
        switch imageLoadingStatus {
        case .success:
            self.subscribedObserver.handlePosterLoadedNotification(wasSuccess: true)
        case .failure:
            self.subscribedObserver.handlePosterLoadedNotification(wasSuccess: false)
        }
        
    }
}
