//
//  ViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import UIKit
import Combine

protocol GenreDelegate {
  func genreSelected(id: Int?, endpoint: Constants.Endpoint)
}

class GenreViewController: UIViewController {
  
  @IBOutlet weak var genreTableView: UITableView!
  
  var specialCategory = ["Popular Movies"]
  var genres: [MovieGenre] = []
  var genreViewModel: MovieGenreViewModel!
  var delegate: GenreDelegate?
  
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
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section{
    case 0:
      return specialCategory.count
    case 1:
      return genres.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    switch indexPath.section {
    case 0:
      cell.textLabel?.text = specialCategory[indexPath.row]
    case 1:
      let genre = genres[indexPath.item]
      cell.textLabel?.text = genre.name
    default:
      return cell
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section{
    case 0:
      return "Choose Genre"
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section{
    case 0:
      //let category = genres[indexPath.row]
      delegate?.genreSelected(id: nil, endpoint: .popularMoviesList)
    case 1:
      let genre = genres[indexPath.row]
      delegate?.genreSelected(id: genre.id, endpoint: .filteredMovieList)
    default:
      return
    }
    dismiss(animated: true, completion: nil)
  }
}

