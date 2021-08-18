//
//  Constants.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import Foundation

struct Constants {
  static let BaseAPI = "https://api.themoviedb.org/3/"
  
  struct APIKey {
    static let Key = "api_key"
    static let Value = "e7d22d38c7ac25f61485e43850ee10e8"
  }
  
  struct Language {
    static let Key = "language"
    static let Value = "en-US"
  }
  
  static let movieGenre = BaseAPI + "genre/movie/list"
}

//enum Language {
//  case english
////  case french
////  case germany
//  var value: String {
//    switch self {
//    case .english:
//      return "en_US"
//    }
//  }
//}

enum Endpoint {
    case genre
    case commentsFetch
    var urlString: String {
        switch self {
        case .genre:
          return Constants.movieGenre
        case .commentsFetch:
          return "https://jsonplaceholder.typicode.com/comments"
        }
    }
}
