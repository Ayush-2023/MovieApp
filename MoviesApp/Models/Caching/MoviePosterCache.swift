//
//  MoviePosterCache.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 01/01/24.
//

import Foundation
import UIKit

class MoviePosterCache {
    private var images: [String: UIImage] = [:]
    
    static var shared: MoviePosterCache = MoviePosterCache()
    
    private init() {  }
    
    func set(image: UIImage, for key: String) {
        self.images[key] = image
    }
    
    func getImage(for key: String) -> UIImage? {
        return self.images[key]
    }
    
}
