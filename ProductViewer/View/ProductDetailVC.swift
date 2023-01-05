//
//  ProductDetailVC.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 3.01.2023.
//  Copyright © 2023 Ensar Koseoglu. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
  var productCode: Int?

  private var viewModel: ProductDetailViewModel!
  private var safeArea: UILayoutGuide!

  private lazy var productInfoView: UIView = {
    let view = UIView()
    return view
  }()

  private lazy var brandLabel: UILabel = {
    let label = UILabel()
    label.textColor = Color.labelBlue
    label.font = UIFont.systemFont(ofSize: 14.0)
    return label
  }()

  private lazy var modelLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14.0)
    return label
  }()

  private lazy var modelDetailLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 12.0)
    label.backgroundColor = Color.backgroundYellow
    return label
  }()

  private lazy var productInfoStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .fill
    return stack
  }()

  private lazy var ratingView: FloatRatingView = {
    let view = FloatRatingView()
    view.backgroundColor = .clear
    view.fullImage = UIImage(named: "StarFull")
    view.emptyImage = UIImage(named: "StarEmpty")
    view.delegate = self
    view.contentMode = .scaleAspectFit
    view.type = .floatRatings
    view.rating = 1.0
    view.isUserInteractionEnabled = false
    return view
  }()

  private lazy var productImageView: UIImageView = {
    let image = UIImageView()
    return image
  }()

  private lazy var seperatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray5
    return view
  }()

  private lazy var storagesView: UIView = {
    let view = UIView()
    view.backgroundColor = Color.viewDefaultGray
    return view
  }()

  private lazy var storageHeaderLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14.0)
    label.text = "Kapasite seçenekleri"
    return label
  }()

  private lazy var storagesStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.spacing = 20.0
    stack.alignment = .fill
    stack.distribution = .fillEqually
    return stack
  }()

  private lazy var priceCountHeaderLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 14.0)
    label.textAlignment = .center
    label.text = "{0} satıcı içinde kargo dahil en ucuz fiyat seçeneği"
    return label
  }()

  private lazy var priceLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private lazy var shippingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14.0)
    label.textColor = Color.labelGreen
    return label
  }()

  private lazy var updateInfoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14.0)
    label.textColor = Color.labelGray
    label.text = "Son güncelleme: {0}"
    return label
  }()

  required public init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    NSLog("has deinitialized")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    pageSetup()
  }

  private func pageSetup() {
    viewSetup()
    viewModelSetup()
    dataSourceSetup()
  }

  private func viewSetup() {
    safeArea = view.layoutMarginsGuide

    self.view.addSubview(productInfoView)
    productInfoView.translatesAutoresizingMaskIntoConstraints = false
    productInfoView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    productInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    productInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    productInfoStackView.addArrangedSubview(brandLabel)
    productInfoStackView.addArrangedSubview(modelLabel)
    productInfoStackView.addArrangedSubview(modelDetailLabel)

    productInfoView.addSubview(productInfoStackView)
    productInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    productInfoStackView.topAnchor.constraint(equalTo: productInfoView.topAnchor, constant: 10.0).isActive = true
    productInfoStackView.leftAnchor.constraint(equalTo: productInfoView.leftAnchor, constant: 10.0).isActive = true

    productInfoView.addSubview(modelDetailLabel)
    modelDetailLabel.translatesAutoresizingMaskIntoConstraints = false
    modelDetailLabel.topAnchor.constraint(equalTo: productInfoStackView.bottomAnchor, constant: 10.0).isActive = true
    modelDetailLabel.leftAnchor.constraint(equalTo: productInfoView.leftAnchor, constant: 10.0).isActive = true

    productInfoView.addSubview(ratingView)
    ratingView.translatesAutoresizingMaskIntoConstraints = false
    ratingView.topAnchor.constraint(equalTo: productInfoView.topAnchor, constant: 10.0).isActive = true
    ratingView.rightAnchor.constraint(equalTo: productInfoView.rightAnchor, constant: -10.0).isActive = true
    ratingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    ratingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true

    view.addSubview(productImageView)
    productImageView.translatesAutoresizingMaskIntoConstraints = false
    productImageView.topAnchor.constraint(equalTo: modelDetailLabel.bottomAnchor, constant: 10.0).isActive = true
    productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    productImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    productImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true

    view.addSubview(seperatorView)
    seperatorView.translatesAutoresizingMaskIntoConstraints = false
    seperatorView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10.0).isActive = true
    seperatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    seperatorView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    seperatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

    view.addSubview(storagesView)
    storagesView.translatesAutoresizingMaskIntoConstraints = false
    storagesView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor).isActive = true
    storagesView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    storagesView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    storagesView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true

    storagesView.addSubview(storageHeaderLabel)
    storageHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
    storageHeaderLabel.topAnchor.constraint(equalTo: storagesView.topAnchor, constant: 10.0).isActive = true
    storageHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    storagesView.addSubview(storagesStackView)
    storagesStackView.translatesAutoresizingMaskIntoConstraints = false
    storagesStackView.topAnchor.constraint(equalTo: storageHeaderLabel.bottomAnchor, constant: 10.0).isActive = true
    storagesStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
    storagesStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true

    view.addSubview(priceCountHeaderLabel)
    priceCountHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
    priceCountHeaderLabel.topAnchor.constraint(equalTo: storagesView.bottomAnchor, constant: 10.0).isActive = true
    priceCountHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    priceCountHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
    priceCountHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true

    view.addSubview(priceLabel)
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    priceLabel.topAnchor.constraint(equalTo: priceCountHeaderLabel.bottomAnchor, constant: 10.0).isActive = true
    priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    view.addSubview(shippingLabel)
    shippingLabel.translatesAutoresizingMaskIntoConstraints = false
    shippingLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10.0).isActive = true
    shippingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    view.addSubview(updateInfoLabel)
    updateInfoLabel.translatesAutoresizingMaskIntoConstraints = false
    updateInfoLabel.topAnchor.constraint(equalTo: shippingLabel.bottomAnchor, constant: 10.0).isActive = true
    updateInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    view.backgroundColor = .white
  }

  private func viewModelSetup() {
    viewModel = ProductDetailViewModel(apiService: NetworkManager(), code: productCode.orEmpty)

    viewModel.onSuccess = { [weak self] () in
      DispatchQueue.main.async {
        guard let view = self, let product = view.viewModel.product else { return }
        view.hideBlockingActivityIndicator()
        view.modelLabel.text = product.productName
        view.brandLabel.text = product.mkName
        view.modelDetailLabel.text = product.badge
        view.ratingView.rating = product.rating.orEmpty
        view.productImageView.setCellImageWithPlaceholder(urlString: product.imageUrl.orEmpty)
        view.priceLabel.attributedText = product.price.orEmpty.formatCurrencyValue()
        view.priceCountHeaderLabel.text = view.priceCountHeaderLabel.text.orEmpty.replacingOccurrences(of: "{0}", with: "\(product.countOfPrices.orEmpty)")
        view.shippingLabel.text = product.freeShipping.orEmpty ? "Ücretsiz kargo" : ""
        view.updateInfoLabel.text = view.updateInfoLabel.text.orEmpty.replacingOccurrences(of: "{0}", with: "\(product.lastUpdate.orEmpty)")
        view.setStorageOptionsView(product)
      }
    }

    viewModel.onFailure = { [weak self] (error) in
      DispatchQueue.main.async {
        guard let view = self, let error else { return }
        view.hideBlockingActivityIndicator()
        print(error.localizedDescription)
      }
    }
  }

  private func dataSourceSetup() {
    showBlockingActivityIndicator()
    viewModel.getProductDetail()
  }

  private func setStorageOptionsView(_ product: ProductDetail) {
    product.storageOptions?.forEach({ storage in
      let storageSubView = UIView()
      storageSubView.clipsToBounds = true
      storageSubView.layer.cornerRadius = 5.0
      storageSubView.layer.borderWidth = 1.0
      storageSubView.backgroundColor = .white

      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 14.0)
      label.text = storage
      label.textAlignment = .center

      storageSubView.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      label.topAnchor.constraint(equalTo: storageSubView.topAnchor, constant: 3.0).isActive = true
      label.bottomAnchor.constraint(equalTo: storageSubView.bottomAnchor, constant: -3.0).isActive = true
      label.leftAnchor.constraint(equalTo: storageSubView.leftAnchor, constant: 3.0).isActive = true
      label.rightAnchor.constraint(equalTo: storageSubView.rightAnchor, constant: -3.0).isActive = true

      if product.productName.orEmpty.contains(storage) {
        storageSubView.layer.borderColor = UIColor.gray.cgColor
      } else {
        storageSubView.layer.borderColor = UIColor.systemGroupedBackground.cgColor
      }
      self.storagesStackView.addArrangedSubview(storageSubView)
      storageSubView.translatesAutoresizingMaskIntoConstraints = false
      storageSubView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    })
  }
}

extension ProductDetailVC: FloatRatingViewDelegate {

}
