//
//  ViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import UIKit
import Combine

class DashboardViewController: UIViewController {

  var genres: [MovieGenre] = []
  var genreViewModel: MovieGenreViewModel!
  
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewModel()
    fetchGenre()
    observeViewModel()
  }
  
  private func setupViewModel() {
    genreViewModel = MovieGenreViewModel(networking: networking, endpoint: .genre)
  }
  
  private func fetchGenre() {
    genreViewModel.fetchGenres()
  }
  
  private func observeViewModel() {
      subscriber = genreViewModel.movieGenreSubject.sink(receiveCompletion: { (resultCompletion) in
          switch resultCompletion {
          case .failure(let error):
              print(error.localizedDescription)
          default: break
          }
      }) { (resultWelcome) in
          DispatchQueue.main.async {
            self.genres = resultWelcome.genres
          }
      }
  }


}

