//
//  BlockingActivityIndicator.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 5.01.2023.
//

import UIKit
import NVActivityIndicatorView

final class BlockingActivityIndicator: UIView {
  private let activityIndicator: NVActivityIndicatorView

  override init(frame: CGRect) {
    self.activityIndicator = NVActivityIndicatorView(
      frame: CGRect(
        origin: .zero,
        size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE
      ),
      color: Color.indicatorBlue
    )
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    super.init(frame: frame)
    backgroundColor = UIColor.white.withAlphaComponent(0.3)
    addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
    ])
  }

  func stopAnimating() {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
    self.removeFromSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
