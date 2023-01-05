//
//  ProductVerticalViewCell.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//

import UIKit

class ProductVerticalViewCell: UICollectionViewCell, CellInterface {

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var discountView: UIView!
  @IBOutlet weak var discountLabel: UILabel!
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productPrice: UILabel!
  @IBOutlet weak var countOfPrices: UILabel!
  @IBOutlet weak var followCount: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    productName.textColor = Color.labelBlue
    containerView.layer.cornerRadius = 5.0
    discountView.layer.cornerRadius = discountView.bounds.height/2.0
  }

  func bind(with product: Product) {
    productName.text = product.name
    followCount.text = "\(product.followCount.orEmpty.roundToNearestHunderedth())+ takip"
    productPrice.attributedText = product.price.orEmpty.formatCurrencyValue()
    countOfPrices.text = "\(product.countOfPrices.orEmpty) satıcı"
    discountLabel.text = "%\(Int(product.dropRatio.orEmpty.rounded(.toNearestOrEven)))"
    productImage.setCellImageWithPlaceholder(urlString: product.imageUrl.orEmpty)
  }
}
