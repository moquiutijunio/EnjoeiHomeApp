//
//  HomeViewController.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import Cartography

enum ProductRequestStatus {
    case loading
    case success
    case failure(error: String)
    case empty
}

class HomeViewController: UIViewController {
    
    private let firstPathPage = "/vNWpzLB9"
    private let secondPathPage = "/X2r3iTxJ"
    private var lastListIsShow = false
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: ProductCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.nibName)
        collectionView.register(UINib(nibName: MessageCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MessageCollectionViewCell.nibName)
        collectionView.register(UINib(nibName: LoadingCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: LoadingCollectionViewCell.nibName)
        
        view.addSubview(collectionView)

        constrain(view, collectionView, car_topLayoutGuide, car_bottomLayoutGuide) { (container, collection, topGuide, bottomGuide) in
            collection.left == container.left
            collection.right == container.right

            if #available(iOS 11.0, *) {
                collection.top == container.safeAreaLayoutGuide.top - 85
                collection.bottom == container.safeAreaLayoutGuide.bottom

            } else {
                collection.top == topGuide.bottom - 65
                collection.bottom == bottomGuide.top
            }
        }
        
        return collectionView
    }()
    
    var productViewModels = [ProductViewModel]()
    private var productRequestStatus: ProductRequestStatus = .loading {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.updateInfinityScrollAndPullToRefresh()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.addPullToRefreshToScrollView { [weak self] (_) in
            self?.pullToRefreshAction()
        }
        
        collectionView.addInfinityScrollRefreshView { [weak self] (_) in
            self?.infinityScrollAction()
        }
        
        requestProductList(path: firstPathPage, reloadViewModels: true)
    }
    
    private func pullToRefreshAction() {
        requestProductList(path: firstPathPage, reloadViewModels: true)
    }
    
    private func infinityScrollAction() {
        requestProductList(path: secondPathPage)
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
                if lastListIsShow {
                    collectionView.ins_setInfinityScrollEnabled(false)
                } else {
                    collectionView.ins_setInfinityScrollEnabled(true)
                }
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

extension HomeViewController {
    
    private func requestProductList(path: String, reloadViewModels: Bool = false) {
        guard let url = URL(string: "\(APIClientHost.baseURLString)\(path)") else {
            productRequestStatus = .failure(error: NSLocalizedString("message.error", comment: ""))
            return
        }
        
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let productsJson = jsonObj!.value(forKey: "products") as? NSArray {
        
                    var products = [Product]()
                    for productJson in productsJson {
                        guard let productJson = productJson as? [String: Any] else { break }
                        guard let product = Product(json: productJson) else { break }
                        products.append(product)
                    }
                    
                    if reloadViewModels {
                        self?.productViewModels = products.map {ProductViewModel(product: $0)}
                    } else {
                        self?.productViewModels.append(contentsOf: products.map {ProductViewModel(product: $0)})
                    }
                    
                    self?.productRequestStatus = .success
                }
            }
        }.resume()
        
        self.lastListIsShow = !reloadViewModels
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            switch productRequestStatus {
            case .success:
                let pading: CGFloat = 6

                let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 10, height: 300)
                collectionViewFlowLayout.minimumLineSpacing = pading
                collectionViewFlowLayout.minimumInteritemSpacing = pading
                collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: pading, left: pading, bottom: pading, right: pading)
                collectionViewFlowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 0)

                return UIEdgeInsets(top: pading, left: pading, bottom: pading, right: pading)

            case .failure,
                 .empty:
                let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 200)
                return UIEdgeInsets()

            case .loading:
                let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 69)
                return UIEdgeInsets()
            }
    }
}

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
            cell.bindIn(viewModel: MessageSectionModel(message: error))
            return cell
            
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.nibName, for: indexPath) as! MessageCollectionViewCell
            cell.bindIn(viewModel: MessageSectionModel(message: NSLocalizedString("product.empty", comment: "")))
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch productRequestStatus {
        case .success:
            print("TODO did tap \(productViewModels[indexPath.row].title)")
            
        default:
            return
        }
    }
}
