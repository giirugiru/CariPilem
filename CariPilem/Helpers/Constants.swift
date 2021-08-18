//
//  Constants.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import Foundation

struct Constants {
  
  // Creds
  struct APIKey {
    static let Key = "api_key"
    static let Value = "e7d22d38c7ac25f61485e43850ee10e8"
  }
  
  // Endpoints & Path
  struct APIPath {
    static let BaseAPI = "https://api.themoviedb.org/3/"
    static let movieGenre = BaseAPI + "genre/movie/list"
    static let popularMovieList = BaseAPI + "movie/popular"
    static let filteredMovieList = BaseAPI + "discover/movie"
  }
  
  // Config & Param Keys
  struct Language {
    static let Key = "language"
    static let Value = "en-US"
  }
  
  struct Page {
    static let Key = "page"
  }
  
  struct Genre {
    static let Key = "with_genres"
  }
  
}

enum Endpoint {
  case genre
  case popularMoviesList
  case filteredMovieList
  
  var urlString: String {
    switch self {
    case .genre:
      return Constants.APIPath.movieGenre
    case .popularMoviesList:
      return Constants.APIPath.popularMovieList
    case .filteredMovieList:
      return Constants.APIPath.filteredMovieList
    }
  }
}
