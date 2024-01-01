//
//  MoviesAPIResponseModel.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import Foundation

struct MoviesAPIMovieModel: Codable, Identifiable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}

struct MoviesAPIResponseModel: Codable {
    var page: Int?
    var results: [MoviesAPIMovieModel]?
    var total_pages: Int?
    var total_results: Int?
}
