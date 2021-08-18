//
//  HomeViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
  
  @IBOutlet weak var movieTableView: UITableView!
  
  var movies: [MovieList] = []
  var movieListViewModel: MovieListViewModel!
  var page = 1
  
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    movieTableView.dataSource = self
    movieTableView.delegate = self
    
    setupViewModel()
    fetchMovies()
    observeViewModel()
    
  }
  
  private func setupViewModel(){
    movieListViewModel = MovieListViewModel(networking: networking, endpoint: .popularMoviesList)
  }
  
  private func fetchMovies(){
    movieListViewModel.fetchMovieList(page: page, genreId: nil)
  }
  
  private func observeViewModel(){
    subscriber = movieListViewModel.movieListSubject.sink(receiveCompletion: { (resultCompletion) in
      switch resultCompletion {
      case .failure(let error):
        print(error.localizedDescription)
      default: break
      }
    }, receiveValue: { (resultWelcome) in
      DispatchQueue.main.async {
        self.movies.append(contentsOf: resultWelcome.results)
        self.movieTableView.reloadData()
      }
    })
  }
  
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    let movie = movies[indexPath.row]
    cell.textLabel?.text = movie.originalTitle
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == movies.count-1 {
      page += 1
      movieListViewModel.fetchMovieList(page: page, genreId: nil)
      observeViewModel()
    }
  }
  
}
