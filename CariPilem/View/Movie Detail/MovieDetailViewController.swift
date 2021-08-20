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
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var taglineLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  @IBOutlet weak var reviewButton: UIButton!
  
  private var menuDetail = ["Summary", "View Trailer", "View Rating"]
  private let networking = Networking()
  private var subscriber: AnyCancellable?
  
  var movieId: Int?
  var movieDetailViewModel: MovieDetailViewModel!
  var movie: MovieDetailWelcome? {
    didSet {
      if let data = movie {
        layoutView(model: data)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewModel()
    fetchMovie()
    observeViewModel()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.scrollView.layoutIfNeeded()
  }
  
  private func setupViewModel(){
    movieDetailViewModel = MovieDetailViewModel(networking: networking, endpoint: .movieDetail)
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
    overviewLabel.text = model.overview
    
    if let rating = model.voteAverage {
      switch rating {
      case ...5.0:
        ratingLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
      case 5.1...7.0:
        ratingLabel.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
      case 7.0...8.0:
        ratingLabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
      default:
        ratingLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      }
      ratingLabel.text = "\(rating)"
    }
    
    if let path = model.posterPath {
      guard let imageURL = URL(string: Constants.APIPath.BaseImageURL + path) else { return }
      posterImage.kf.setImage(with: imageURL)
    }
    if let genres = model.genres {
      var genreCollection: [String] = []
      for genre in genres {
        genreCollection.append(genre.name)
      }
      genreLabel.text = genreCollection.joined(separator: ", ")
    }
    
  }
  
  @IBAction func reviewButtonTapped(_ sender: UIButton) {
    let vc = ReviewViewController(nibName: String(describing: ReviewViewController.self), bundle: nil)
    vc.movieId = movieId
    navigationController?.pushViewController(vc, animated: true)
  }
  
}
