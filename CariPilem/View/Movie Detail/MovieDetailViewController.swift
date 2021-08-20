//
//  MovieDetailViewController.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 19/08/21.
//

import UIKit
import Combine
import Kingfisher

class MovieDetailViewController: UIViewController {
  
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var taglineLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var detailTableView: UITableView!
  
  private var menuDetail = ["Summary", "View Trailer", "View Rating"]
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  var movieId: Int?
  var movieDetailViewModel: MovieDetailViewModel!
  var movie: MovieDetailWelcome? {
    didSet {
      if let data = movie {
        layoutView(model: data)
        detailTableView.reloadData()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewModel()
    fetchMovie()
    observeViewModel()
    setupTable()
  }
  
  private func setupViewModel(){
    movieDetailViewModel = MovieDetailViewModel(networking: networking, endpoint: .movieDetail)
  }
  
  private func setupTable(){
    detailTableView.register(DetailMenuTableViewCell.nib(), forCellReuseIdentifier: DetailMenuTableViewCell.cellIdentifier)
    detailTableView.delegate = self
    detailTableView.dataSource = self
  }
  
  private func fetchMovie(){
    if let id = movieId {
      movieDetailViewModel.fetchMovieDetail(movieId: id)
    }
  }
  
  private func observeViewModel(){
    subscriber = movieDetailViewModel.movieDetailSubject.sink(receiveCompletion: { (resultCompletion) in
      switch resultCompletion {
      case .failure(let error):
        print(error.localizedDescription)
      default: break
      }
    }, receiveValue: { (resultWelcome) in
      DispatchQueue.main.async {
        self.movie = resultWelcome
      }
    })
  }
  
  private func layoutView(model: MovieDetailWelcome){
    titleLabel.text = model.title
    taglineLabel.text = model.tagline

    if let rating = model.voteAverage {
      ratingLabel.text = "\(rating)"
    }
    
    if let path = model.posterPath {
      guard let imageURL = URL(string: Constants.APIPath.BaseImageURL + path) else { return }
      posterImage.kf.setImage(with: imageURL)
    }
  }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuDetail.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DetailMenuTableViewCell.cellIdentifier, for: indexPath) as! DetailMenuTableViewCell
    cell.menuTitleLabel.text = menuDetail[indexPath.row]
    switch indexPath.row {
    case 0:
      cell.selectionStyle = .none
      cell.subtitleLabel.text = movie?.overview
    default:
      cell.subtitleLabel.isHidden = true
      return cell
    }
    return cell
  }
}
