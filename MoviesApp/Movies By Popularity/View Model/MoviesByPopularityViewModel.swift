//
//  MoviesByPopularityViewModel.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import Foundation

enum DataLoadingStatus: Int {
    case success, failure
}

class MoviesByPopularityViewModel {
    private var loadedPages: Int?
    private var lastPage: Int?
    private var moviesList: [MoviesAPIMovieModel]
    private var subscribedViewController: MoviesByPopularityViewController
    private var responseCahce: [Int: [MoviesAPIMovieModel]]
    private var movieDBNetworkService: MovieDBNetworkService
    
    
    init(subscriber: MoviesByPopularityViewController) {
        self.loadedPages = nil
        self.lastPage = nil
        self.subscribedViewController = subscriber
        self.movieDBNetworkService = .shared
        self.responseCahce = [:]
        self.moviesList = []
    }
}

// Infacing View (Getters)
extension MoviesByPopularityViewModel {
    func getMoviesCount() -> Int {
        return self.moviesList.count
    }
    
    func getMovieDetailsViewModel(forRow index: Int) -> MoviesAPIMovieModel? {
        return self.moviesList[index]
    }
    
    func allPagesLoaded() -> Bool{
        guard let loadedPages, let lastPage else {
            return false
        }
        return loadedPages == lastPage
    }
}

// Interfacing Model & Controller (Networking & Searching)
extension MoviesByPopularityViewModel {
    func loadFirstPage() {
        
        self.loadPage(1)
    }
    
    func loadNextPage() {
        if allPagesLoaded() == false {
            self.loadPage(self.loadedPages! + 1)
        }
    }
    
    func loadPage(_ page: Int) {
        
        if responseCahce[page] != nil {
            self.notifyViewController(forPage: page, loadingStatus: .success)
        }
        
        self.movieDBNetworkService.getRequest(.moviesByPopularity(page)) { response in
            guard let response = response as? MoviesAPIResponseModel else {
                self.notifyViewController(forPage: page, loadingStatus: .failure)
                return
            }
            self.processResponse(forPage: page, response: response, onSuccess: {
                self.notifyViewController(forPage: page, loadingStatus: .success)
            }, onFailure: {
                self.notifyViewController(forPage: page, loadingStatus: .failure)
            })
        }
    }
    
    
    
    func processResponse(forPage page: Int, response: MoviesAPIResponseModel, onSuccess: @escaping ()->(Void), onFailure: @escaping ()->(Void)) {
        
        guard let lastPage = response.total_pages, let movies = response.results else {
            onFailure()
            return
        }
        
        self.loadedPages = page
        self.lastPage = lastPage
        self.responseCahce[page] = movies
        self.moviesList.append(contentsOf: movies)
        onSuccess()
    }
    
    func notifyViewController(forPage page: Int, loadingStatus: DataLoadingStatus) {
        switch loadingStatus {
        case .success:
            self.subscribedViewController.handlePageLoadedNotification(for: page, wasSuccess: true)
        case .failure:
            self.subscribedViewController.handlePageLoadedNotification(for: page, wasSuccess: false)
        }
    }
}


