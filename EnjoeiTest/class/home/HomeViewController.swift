//
//  HomeViewController.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift
import Cartography

enum ProductRequestStatus {
    case loading
    case success
    case failure(error: String)
    case empty
}

class HomeViewController: UIViewController {
    
    private var disposeBag: DisposeBag!
    private let apiClient = APIClient()
    
    private var currentPage = 1
    private var productViewModels = [ProductViewModel]()
    private var productRequestStatus: ProductRequestStatus = .loading {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.updateInfinityScrollAndPullToRefresh()
            }
        }
    }
    
    private lazy var homeHeaderView: HomeHeaderView = {
        return HomeHeaderView.instantiateFromNib()
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: ProductCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.nibName)
        collectionView.register(UINib(nibName: MessageCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MessageCollectionViewCell.nibName)
        collectionView.register(UINib(nibName: LoadingCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: LoadingCollectionViewCell.nibName)
        
        return collectionView
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.addPullToRefreshToScrollView {[unowned self] (_) in
            self.pullToRefreshAction()
        }
        
        collectionView.addInfinityScrollRefreshView {[unowned self] (_) in
            self.infinityScrollAction()
        }
        
        pullToRefreshAction()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func bind() {
        disposeBag = DisposeBag()
        
        apiClient.productListRequestResponse
            .bind {[weak self] (response) in
                guard let self = self else { return }
                
                switch response {
                case .loading:
                    if self.productViewModels.isEmpty {
                        self.productRequestStatus = .loading
                    }
                    
                case .success(let products):
                    if self.currentPage == 1 {
                        self.productViewModels = products.map {ProductViewModel(product: $0)}
                    } else {
                        self.productViewModels.append(contentsOf: products.map {ProductViewModel(product: $0)})
                    }
                    
                    self.productRequestStatus = .success
                    
                case .failure(let error):
                    if self.productViewModels.isEmpty {
                        self.productRequestStatus = .failure(error: error)
                    } else {
                        self.showAlertWithError(error)
                    }
                    
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func showAlertWithError(_ message: String) {
        let alertView = UIAlertController(title: NSLocalizedString("error.title", comment: ""), message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: "").uppercased(), style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}

// MARK: - Layout subviews
extension HomeViewController {
    
    private func addSubviews() {
        
        view.addSubview(homeHeaderView)
        view.addSubview(collectionView)
        
        constrain(view, collectionView, homeHeaderView) { (container, collection, headerView) in
            headerView.left == container.left
            headerView.right == container.right
            
            collection.top == headerView.bottom
            collection.left == container.left
            collection.right == container.right
            
            if #available(iOS 11.0, *) {
                headerView.top == container.safeAreaLayoutGuide.top
                collection.bottom == container.safeAreaLayoutGuide.bottom
                
            } else {
                headerView.top == container.top + 20
                collection.bottom == container.bottom
            }
        }
    }
}

// MARK: - Route method
extension HomeViewController {
    
    private func goToProductDetailsWith(_ product: Product) {
        let productDetailsViewController = ProductDetailsViewController(product: product)
        productDetailsViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
    }
}

// MARK: - Pull to refresh and infinity scroll methods
extension HomeViewController {
    
    private func pullToRefreshAction() {
        currentPage = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.apiClient.getProductList(currentPage: self.currentPage)
        }
    }
    
    private func infinityScrollAction() {
        currentPage += 1
        apiClient.getProductList(currentPage: currentPage)
    }
    
    private func updateInfinityScrollAndPullToRefresh() {
        switch self.productRequestStatus {
        case .success:
            collectionView.ins_endPullToRefresh()
            collectionView.ins_endInfinityScroll(withStoppingContentOffset: true)
            if productViewModels.isEmpty {
                collectionView.ins_setPull(toRefreshEnabled: true)
                collectionView.ins_setInfinityScrollEnabled(false)
            } else {
                collectionView.ins_setPull(toRefreshEnabled: true)
                collectionView.ins_setInfinityScrollEnabled(true)
            }
            
        case .loading:
            collectionView.ins_endPullToRefresh()
            collectionView.ins_endInfinityScroll(withStoppingContentOffset: true)
            collectionView.ins_setPull(toRefreshEnabled: false)
            collectionView.ins_setInfinityScrollEnabled(false)
            
        case .failure,
             .empty:
            collectionView.ins_endPullToRefresh()
            collectionView.ins_endInfinityScroll(withStoppingContentOffset: true)
            collectionView.ins_setPull(toRefreshEnabled: true)
            collectionView.ins_setInfinityScrollEnabled(false)
        }
    }
}

// MARK: - MessageViewModelCallbackProtocol
extension HomeViewController: MessageViewModelCallbackProtocol {
    
    func tryAgain() {
        productRequestStatus = .loading
        apiClient.getProductList(currentPage: currentPage)
    }
}

// MARK: - UICollectionView delegate flow layout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            switch productRequestStatus {
            case .success:
                let pading: CGFloat = 10

                let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 15, height: 300)
                collectionViewFlowLayout.minimumLineSpacing = pading
                collectionViewFlowLayout.minimumInteritemSpacing = pading
                collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: pading, left: pading, bottom: pading, right: pading)
                collectionViewFlowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 0)

                return UIEdgeInsets(top: pading, left: pading, bottom: pading, right: pading)

            case .failure:
                let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 160)
                return UIEdgeInsets()

            case .loading:
                let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 69)
                return UIEdgeInsets()
                
            default:
                return UIEdgeInsets()
            }
    }
}

// MARK: - UICollectionView Delegate and DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch productRequestStatus {
        case .success:
            return productViewModels.count
            
        case .loading,
             .failure:
            return 1
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch productRequestStatus {
        case .success:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.nibName, for: indexPath) as! ProductCollectionViewCell
            cell.bindIn(viewModel: productViewModels[indexPath.row])
            return cell
            
        case .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.nibName, for: indexPath) as! LoadingCollectionViewCell
            return cell

        case .failure(let error):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.nibName, for: indexPath) as! MessageCollectionViewCell
            cell.bindIn(viewModel: MessageViewModel(title: error, callback: self))
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch productRequestStatus {
        case .success:
            goToProductDetailsWith(productViewModels[indexPath.row].product)
            
        default:
            return
        }
    }
}
