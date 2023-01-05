//
//  ProductListVC.swift
//  ProductViewer
//
//  Created by EnsarKoseoglu on 30.12.2022.
//

import UIKit

class ProductListVC: UIViewController {
  fileprivate var viewModel: ProductListViewModel!
  private var safeArea: UILayoutGuide!

  fileprivate lazy var horizontalContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  fileprivate lazy var horizontalCollectionView: UICollectionView = { [unowned self] in
    $0.dataSource = self
    $0.delegate = self
    $0.register(ProductHorizontalViewCell.cellNib, forCellWithReuseIdentifier: ProductHorizontalViewCell.id)
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.decelerationRate = UIScrollView.DecelerationRate.normal
    $0.contentInsetAdjustmentBehavior = .always
    $0.bounces = true
    $0.backgroundColor = .clear
    $0.layer.masksToBounds = false
    $0.clipsToBounds = false
    $0.isPagingEnabled = true
    $0.backgroundColor = .white
    $0.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    $0.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    return $0
  }(UICollectionView(frame: .zero, collectionViewLayout: horizontalLayout))

  fileprivate lazy var horizontalLayout: UICollectionViewFlowLayout = {
    $0.minimumLineSpacing = 0.0
    $0.scrollDirection = .horizontal
    return $0
  }(UICollectionViewFlowLayout())

  fileprivate lazy var horizontalProductsPageControl: UIPageControl = {
    let pageControl = UIPageControl(frame: .zero)
    pageControl.currentPageIndicatorTintColor = Color.indicatorBlue
    pageControl.pageIndicatorTintColor = .systemGroupedBackground
    return pageControl
  }()

  fileprivate lazy var verticalCollectionView: UICollectionView = { [unowned self] in
    $0.dataSource = self
    $0.delegate = self
    $0.register(ProductVerticalViewCell.cellNib, forCellWithReuseIdentifier: ProductVerticalViewCell.id)
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.decelerationRate = UIScrollView.DecelerationRate.normal
    $0.contentInsetAdjustmentBehavior = .always
    $0.bounces = true
    $0.backgroundColor = .clear
    $0.layer.masksToBounds = false
    $0.clipsToBounds = false
    $0.backgroundColor = .systemGroupedBackground
    return $0
  }(UICollectionView(frame: .zero, collectionViewLayout: verticalLayout))

  fileprivate lazy var verticalLayout: UICollectionViewFlowLayout = {
    $0.minimumInteritemSpacing = 4.0
    $0.minimumLineSpacing = 4.0
    $0.sectionInset = .zero
    $0.scrollDirection = .vertical
    return $0
  }(UICollectionViewFlowLayout())

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
    self.view.addSubview(horizontalContainerView)
    horizontalContainerView.translatesAutoresizingMaskIntoConstraints = false
    horizontalContainerView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    horizontalContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    horizontalContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    horizontalContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22).isActive = true

    horizontalContainerView.addSubview(horizontalCollectionView)
    horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
    horizontalCollectionView.topAnchor.constraint(equalTo: horizontalContainerView.topAnchor).isActive = true
    horizontalCollectionView.leftAnchor.constraint(equalTo: horizontalContainerView.leftAnchor).isActive = true
    horizontalCollectionView.rightAnchor.constraint(equalTo: horizontalContainerView.rightAnchor).isActive = true

    horizontalContainerView.addSubview(horizontalProductsPageControl)
    horizontalProductsPageControl.translatesAutoresizingMaskIntoConstraints = false
    horizontalProductsPageControl.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 20.0).isActive = true
    horizontalProductsPageControl.leftAnchor.constraint(equalTo: horizontalContainerView.leftAnchor).isActive = true
    horizontalProductsPageControl.rightAnchor.constraint(equalTo: horizontalContainerView.rightAnchor).isActive = true
    horizontalProductsPageControl.bottomAnchor.constraint(equalTo: horizontalContainerView.bottomAnchor).isActive = true

    self.view.addSubview(verticalCollectionView)
    verticalCollectionView.translatesAutoresizingMaskIntoConstraints = false
    verticalCollectionView.topAnchor.constraint(equalTo: horizontalContainerView.bottomAnchor, constant: 20.0).isActive = true
    verticalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    verticalCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    verticalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    view.backgroundColor = .systemGroupedBackground
  }

  private func viewModelSetup() {
    viewModel = ProductListViewModel(apiService: NetworkManager())

    viewModel.onSuccess = { [weak self] () in
      DispatchQueue.main.async {
        guard let view = self else { return }
        view.hideBlockingActivityIndicator()
        view.horizontalProductsPageControl.numberOfPages = view.viewModel.horizontalProducts.count
        view.verticalCollectionView.reloadData()
        view.horizontalCollectionView.reloadData()
      }
    }

    viewModel.onFailure = { [weak self] (error) in
      DispatchQueue.main.async {
        guard let view = self, let error else { return }
        view.hideBlockingActivityIndicator()
        view.verticalCollectionView.reloadData()
        view.horizontalCollectionView.reloadData()
        print(error.localizedDescription)
      }
    }
  }

  private func dataSourceSetup() {
    showBlockingActivityIndicator()
    viewModel.getProducts()
  }

  private func showProductDetail(_ code: Int?) {
    let detailVc = ProductDetailVC()
    detailVc.productCode = code
    self.present(detailVc, animated: true)
  }
}

extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == horizontalCollectionView {
      return viewModel.horizontalProducts.count
    }
    return viewModel.verticalProducts.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == horizontalCollectionView {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductHorizontalViewCell.id, for: indexPath) as? ProductHorizontalViewCell else {
        return UICollectionViewCell()
      }
      let product = viewModel.horizontalProducts[indexPath.row]
      cell.bind(with: product)
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductVerticalViewCell.id, for: indexPath) as? ProductVerticalViewCell else {
        return UICollectionViewCell()
      }
      let product = viewModel.verticalProducts[indexPath.row]
      cell.bind(with: product)
      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if collectionView == verticalCollectionView {
      if indexPath.row == viewModel.verticalProducts.count - 1 && !viewModel.pageId.isEmpty{
        viewModel.getProducts(true)
      }
    }
    if collectionView == horizontalCollectionView {
      self.horizontalProductsPageControl.currentPage = indexPath.row
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var code: Int?
    if collectionView == horizontalCollectionView {
      code = viewModel.horizontalProducts[indexPath.row].code
    } else {
      code = viewModel.verticalProducts[indexPath.row].code
    }
    showProductDetail(code)
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 50 {
      self.horizontalContainerView.isHidden = true
    } else {
      self.horizontalContainerView.isHidden = false
    }
  }
}

extension ProductListVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == verticalCollectionView {
      if let lay = collectionViewLayout as? UICollectionViewFlowLayout {
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8.0, height: 300.0)
      }
      return CGSize(width: 250.0, height: 250.0)
    }
    return CGSize(width: view.frame.width, height: 200.0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if collectionView == horizontalCollectionView {
      return 0.0
    }
    return 8.0
  }
}
