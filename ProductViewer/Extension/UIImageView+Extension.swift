//
//  UIImageView+Extension.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
  func setCellImageWithPlaceholder(urlString: String) {
    let processor = DownsamplingImageProcessor(size: self.bounds.size)
    |> RoundCornerImageProcessor(cornerRadius: 5)
    self.kf.indicatorType = .activity
    let retry = DelayRetryStrategy(maxRetryCount: 5, retryInterval: .seconds(3))
    self.kf.setImage(with: URL(string: urlString), placeholder: UIImage(named: "jpg"), options: [
      .processor(processor),
      .scaleFactor(UIScreen.main.scale),
      .transition(.fade(0.2)),
      .cacheOriginalImage,
      .retryStrategy(retry)
    ]) { result in
      switch result {
      case .success(_):
        self.contentMode = .scaleAspectFit
      case .failure(_):
        self.contentMode = .scaleAspectFit
      }
    }
  }
}
