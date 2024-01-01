//
//  MovieDBNetworkService.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import Foundation
import UIKit

enum MovieDBRequest {
    case moviePoster(String)
    case moviesByPopularity(Int)
    case moviesByTitle(String,Int)
}

class MovieDBNetworkService {
    
    static let shared = MovieDBNetworkService()
    private init() {  }
    
    var networkService: NetworkService = NetworkService.shared
    var decoder: JSONDecoder = JSONDecoder()
    
    func getRequest(_ request: MovieDBRequest, onCompletion: @escaping (Any?) -> (Void)){
        switch request {
        case .moviePoster(let fileName):
            self.loadMoviePoster(using: fileName, onCompletion: onCompletion)
        case .moviesByPopularity(let page):
            self.loadMoviesByPopularity(from: page, onCompletion: onCompletion)
        case .moviesByTitle(let title, let page):
            self.loadMoviesByTitle(with: title, from: page, onCompletion: onCompletion)
        }
    }
    
    func loadMoviePoster(using filename: String, onCompletion: @escaping (UIImage?) -> (Void)){
        
        let baseUrlString = POSTER_IMAGE_BASE_PATH
        let urlString = baseUrlString + filename
        guard let url = URL(string: urlString) else {
            // Invalid URL string
            return
        }
        
        networkService.fetchData(using: URLRequest(url: url)) { (data) in
            guard let imageData = data else {
                // Invalid Response
                onCompletion(nil)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                // Invalid Data
                onCompletion(nil)
                return
            }
            
            onCompletion(image)
        }
        
    }
    
    func loadMoviesByPopularity(from page: Int = 1, onCompletion: @escaping (MoviesAPIResponseModel?) -> (Void))  {
        
        let baseUrlString = API_MOVIES_BY_POPULARITY_URL_STRING
        let queryParams = [ "api_key" : API_KEY,
                            "language" : LANG_CODE,
                            "page" : String(page)   ]
        
        networkService.requestJsonData(from: baseUrlString, using: queryParams) { data in
            guard let jsonData = data else {
                // Invalid Response
                onCompletion(nil)
                return
            }
            
            let moviesResults = try? self.decoder.decode(MoviesAPIResponseModel.self, from: jsonData)
            
            guard let moviesResults = moviesResults else {
                // Invalid Data
                onCompletion(nil)
                return
            }
            
            onCompletion(moviesResults)
        }
    }
    
    func loadMoviesByTitle(with title: String, from page: Int = 1, onCompletion: @escaping (MoviesAPIResponseModel?) -> (Void)) {
        
        let baseUrlString = API_MOVIES_BY_TITLe_URL_STRING
        let queryParams = [ "api_key" : API_KEY,
                            "language" : LANG_CODE,
                            "query" : title,
                            "page" : String(page)     ]
        
        networkService.requestJsonData(from: baseUrlString, using: queryParams) { data in
            guard let jsonData = data else {
                // Invalid Response
                onCompletion(nil)
                return
            }
            
            let moviesResults = try? self.decoder.decode(MoviesAPIResponseModel.self, from: jsonData)
            
            guard let moviesResults = moviesResults else {
                // Invalid Data
                onCompletion(nil)
                return
            }
            
            onCompletion(moviesResults)
        }
        
    }
}
