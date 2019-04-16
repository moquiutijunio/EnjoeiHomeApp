//
//  ProductDetailsViewController.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import Cartography

class ProductDetailsViewController: UIViewController {
    
    private let currentProduct: Product
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 370)
        
        return collectionViewLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = currentProduct.images.count
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.91, green: 0.34, blue: 0.34, alpha: 1)
        return pageControl
    }()
    
    private lazy var productDetailsView: ProductPriceView = {
        let productDetailsView = ProductPriceView.instantiateFromNib()
        productDetailsView.bindIn(viewModel: ProductPriceViewModel(product: currentProduct))
        return productDetailsView
    }()
    
    init(product: Product) {
        self.currentProduct = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyAppearance()
        applyNavigationAppearance()
        updateBackBarButton()
        prepareCollectionView()
    }
    
    private func applyAppearance() {
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: PhotoHeaderCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PhotoHeaderCollectionViewCell.nibName)
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

// MARK: - Layout subviews
extension ProductDetailsViewController {
    
    private func addSubviews() {
        
        view.insertSubview(pageControl, at: 1)
        view.insertSubview(collectionView, at: 0)
        view.addSubview(productDetailsView)
        
        constrain(view, collectionView, pageControl, productDetailsView) { (container, collection, page, detailsView) in
            collection.left == container.left
            collection.right == container.right
            collection.top == container.top
            collection.width == container.width
            collection.height == 370
            
            page.top == collection.bottom - 20
            page.left == container.left
            page.right == container.right
            page.width == container.width
            page.height == 16
            
            collection.bottom == detailsView.top
            detailsView.left == container.left
            detailsView.right == container.right
            detailsView.width == container.width
        }
    }
}

// MARK: - NavigationController methods
extension ProductDetailsViewController {
    
    private func updateBackBarButton() {
        let backImage = UIImage(named: "ic_back")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.backItem?.title = ""
        
        // MARK: - Works only on iOS 10
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func applyNavigationAppearance() {
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK: - UICollectionView Delegate and DataSource
extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentProduct.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoHeaderCollectionViewCell.nibName, for: indexPath) as! PhotoHeaderCollectionViewCell
        cell.bindIn(imageURL: currentProduct.images[indexPath.row].imageURL)
        return cell
    }
}

// MARK: - ScrollView callbacks
extension ProductDetailsViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        pageControl.currentPage = page
    }
}
