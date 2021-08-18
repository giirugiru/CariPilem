//
//  ViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import UIKit
import Combine

class GenreViewController: UIViewController {
  
  @IBOutlet weak var genreTableView: UITableView!
  
  var genres: [MovieGenre] = []
  var genreViewModel: MovieGenreViewModel!
  
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    genreTableView.delegate = self
    genreTableView.dataSource = self
    
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
        self.genreTableView.reloadData()
      }
    }
  }
  
}

extension GenreViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    genres.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    let genre = genres[indexPath.item]
    cell.textLabel?.text = genre.name
    return cell
  }
}

