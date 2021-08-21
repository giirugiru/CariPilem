//
//  ReviewTableViewCell.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 20/08/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
  
  @IBOutlet weak var authorImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var reviewTextView: UITextView!
  
  static let cellIdentifier = String(describing: ReviewTableViewCell.self)
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  static func nib() -> UINib {
    return UINib(nibName: cellIdentifier, bundle: nil)
  }
  
  public func configure(with model: ReviewResult){
    nameLabel.text = model.author
    reviewTextView.text = model.content
    
    if let rating = model.authorDetails?.rating {
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
      ratingLabel.text = "\(rating)/10"
    } else {
      ratingLabel.isHidden = true
    }
    
    if let path = model.authorDetails?.avatarPath {
      guard let imageURL = URL(string: Constants.APIPath.BaseImageURL + path) else { return }
      authorImage.kf.setImage(with: imageURL)
    }
  }
}
