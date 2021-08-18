//
//  MovieGenreViewModel.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import Foundation
import Combine

// https://api.themoviedb.org/3/genre/movie/list?api_key=e7d22d38c7ac25f61485e43850ee10e8&language=en-US

class MovieGenreViewModel {
  
  // Dependency Injection
  private let networking: NetworkProtocol
  private let endpoint: Endpoint
  
  var movieGenreSubject = PassthroughSubject<MovieGenreWelcome, Error>()
  
  init(networking: NetworkProtocol, endpoint: Endpoint) {
    self.networking = networking
    self.endpoint = endpoint
  }
  
  func fetchGenres() {
    let url = endpoint.urlString
    let param = [
      Constants.APIKey.Key: Constants.APIKey.Value,
      Constants.Language.Key: Constants.Language.Value
    ]
    networking.fetchItems(url: url, parameters: param) { [weak self] (result: Result<MovieGenreWelcome, Error>) in
      switch result {
      case .success(let genres):
        self?.movieGenreSubject.send(genres)
      case .failure(let error):
        self?.movieGenreSubject.send(completion: .failure(error))
      }
    }
  }
  
}
