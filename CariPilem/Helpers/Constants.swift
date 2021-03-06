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
    static let BaseImageURL = "https://image.tmdb.org/t/p/w500"
    static let movieGenre = BaseAPI + "genre/movie/list"
    static let popularMovieList = BaseAPI + "movie/popular"
    static let filteredMovieList = BaseAPI + "discover/movie"
    static let movieDetail = BaseAPI + "movie"
    static let movieReview = BaseAPI + "movie/$$$/reviews"
    static let movieTrailer = BaseAPI + "movie/$$$/videos"
  }
  
  struct YoutubePath {
    static let Path = "https://www.youtube.com/watch?v="
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
  
  struct Trailer {
    static let Key = "append_to_response"
    static let Value = "videos"
  }
  
  enum Endpoint {
    case genre
    case popularMoviesList
    case filteredMovieList
    case movieDetail
    case movieReview
    case movieTrailer
    
    var urlString: String {
      switch self {
      case .genre:
        return Constants.APIPath.movieGenre
      case .popularMoviesList:
        return Constants.APIPath.popularMovieList
      case .filteredMovieList:
        return Constants.APIPath.filteredMovieList
      case .movieDetail:
        return Constants.APIPath.movieDetail
      case .movieReview:
        return Constants.APIPath.movieReview
      case .movieTrailer:
        return Constants.APIPath.movieTrailer
      }
    }
  }
}


