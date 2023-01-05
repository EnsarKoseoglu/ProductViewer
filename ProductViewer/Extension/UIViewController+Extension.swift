//
//  UIViewController+Extension.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 5.01.2023.
//

import UIKit

extension UIViewController {
  func showBlockingActivityIndicator() {
    guard !self.view.subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
      return
    }

    let activityIndicator = BlockingActivityIndicator()
    activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    activityIndicator.frame = self.view.frame
    UIView.transition(
      with: self.view,
      duration: 0.3,
      options: .transitionCrossDissolve,
      animations: {
        self.view.addSubview(activityIndicator)
      }
    )
    self.view.isUserInteractionEnabled = false
  }

  func hideBlockingActivityIndicator() {
    let views = self.view.subviews.filter { $0 is BlockingActivityIndicator }
    views.forEach { (activity) in
      (activity as? BlockingActivityIndicator)?.stopAnimating()
    }
    self.view.isUserInteractionEnabled = true
  }
}
