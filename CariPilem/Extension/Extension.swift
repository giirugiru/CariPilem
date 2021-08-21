//
//  TableViewExtension.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 21/08/21.
//

import Foundation
import UIKit

extension UITableView {
  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
    messageLabel.sizeToFit()
    self.backgroundView = messageLabel
    self.separatorStyle = .none
  }
  
  func restore(style: UITableViewCell.SeparatorStyle) {
    self.backgroundView = nil
    self.separatorStyle = style
  }
}

extension  UIViewController {
  func showAlert(withTitle title: String, withMessage message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
    })
    alert.addAction(ok)
    DispatchQueue.main.async(execute: {
      self.present(alert, animated: true)
    })
  }
}
