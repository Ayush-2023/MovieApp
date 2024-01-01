//
//  AppConstants.swift
//  MoviesApp
//
//  Created by Ayush Kumar Sinha on 31/12/23.
//

import Foundation

let API_MOVIES_BY_POPULARITY_URL_STRING = "https://api.themoviedb.org/3/movie/now_playing"
let API_MOVIES_BY_TITLe_URL_STRING = "https://api.themoviedb.org/3/search/movie"

let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
let LANG_CODE = "en-US"
    
let POSTER_IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/w500/"


