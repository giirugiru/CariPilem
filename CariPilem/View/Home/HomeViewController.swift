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
  @IBOutlet weak var genreTabButton: UIBarButtonItem!
  
  var movies: [MovieList] = []
  var movieListViewModel: MovieListViewModel!
  var page = 1
  var maxPage: Int?
  var genreId: Int?
  var genreValue: String = "Popular Movies"
  var endpoint: Constants.Endpoint = .popularMoviesList
  
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTable()
    setupViewModel()
    fetchMovies()
    observeViewModel()
  }
  
  private func setupTable(){
    movieTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.cellIdentifier)
    movieTableView.dataSource = self
    movieTableView.delegate = self
    movieTableView.showsVerticalScrollIndicator = false
    movieTableView.bounces = false
  }
  
  private func setupViewModel(){
    movieListViewModel = MovieListViewModel(networking: networking, endpoint: .popularMoviesList)
  }
  
  private func fetchMovies(){
    movieListViewModel.fetchMovieList(page: page, genreId: genreId)
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
        self.maxPage = resultWelcome.totalPages
        self.movies.append(contentsOf: resultWelcome.results)
        self.movieTableView.reloadData()
      }
    })
  }
  
  @IBAction func genreButtonTapped(_ sender: UIBarButtonItem) {
    let vc = GenreViewController(nibName: String(describing: GenreViewController.self), bundle: nil)
    vc.delegate = self
    self.navigationController?.present(vc, animated: true, completion: nil)
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let headerView = view as? UITableViewHeaderFooterView {
      headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier, for: indexPath) as! MovieTableViewCell
    let model = movies[indexPath.row]
    cell.configure(with: model)
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == movies.count-1 {
      page += 1
      if let max = maxPage {
        if page < max {
          movieListViewModel.fetchMovieList(page: page, genreId: genreId)
          observeViewModel()
        }
      }
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return genreValue
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let model = movies[indexPath.row]
    let vc = MovieDetailViewController(nibName: String(describing: MovieDetailViewController.self), bundle: nil)
    vc.movieId = model.id
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

extension HomeViewController: GenreDelegate {
  func genreSelected(id: Int?, value: String, endpoint: Constants.Endpoint) {
    page = 1
    genreId = id
    movies.removeAll()
    genreValue = value
    
    movieListViewModel = MovieListViewModel(networking: networking, endpoint: endpoint)
    movieListViewModel.fetchMovieList(page: page, genreId: genreId)
    observeViewModel()
  }
}
