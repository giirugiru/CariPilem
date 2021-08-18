//
//  MovieListViewModel.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import Foundation
import Combine

// https://api.themoviedb.org/3/movie/popular?api_key=e7d22d38c7ac25f61485e43850ee10e8

// https://api.themoviedb.org/3/discover/movie?api_key=e7d22d38c7ac25f61485e43850ee10e8&language=en-US&sort_by=popularity.desc&page=10&with_genres=18

class MovieListViewModel {
  
  // Dependency Injection
  private let networking: NetworkProtocol
  private let endpoint: Endpoint
  
  var movieListSubject = PassthroughSubject<MovieListWelcome, Error>()
  
  init(networking: NetworkProtocol, endpoint: Endpoint) {
    self.networking = networking
    self.endpoint = endpoint
  }
  
  func fetchMovieList(page: Int, genreId: Int?) {
    let url = endpoint.urlString
    var param = [
      Constants.APIKey.Key: Constants.APIKey.Value,
      Constants.Language.Key: Constants.Language.Value,
      Constants.Page.Key: "\(page)"
    ]
    
    if let id = genreId {
      param[Constants.Genre.Key] = "\(id)"
    }
    
    networking.fetchItems(url: url, parameters: param) { [weak self] (result: Result<MovieListWelcome, Error>) in
      switch result {
      case .success(let resultWelcome):
        self?.movieListSubject.send(resultWelcome)
      case .failure(let error):
        self?.movieListSubject.send(completion: .failure(error))
      }
    }
  }
  
}
