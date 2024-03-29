//
//  APIClient.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol APIClientProtocol {
    var productListRequestResponse: Observable<RequestResponse<[Product]>> { get }
    
    func getProductList(currentPage: Int)
}

class APIClient {
    
    static let baseURLString = "https://pastebin.com/raw"
    static let photoBaseURLString = "https://photos.enjoei.com.br/public"
    
    //Current User Avatar Image
    static let currentUserAvatarURL = URL(string: "https://photos.enjoei.com.br/karen-bachinii/100x100/czM6Ly9waG90b3MuZW5qb2VpLmNvbS5ici9hdmF0YXJzLzQ3ODM3NjcvMWNjYmFlZWUwZDhiM2ZkYWY0NzU1OWFjNjAyOGM4MDAuanBn.jpg")!
    
    //Product List paths
    static let productFirstPathPage = "/vNWpzLB9"
    static let productNextPathPage = "/X2r3iTxJ"
    
    private var productListRequestResponseSubject = BehaviorSubject<RequestResponse<[Product]>>(value: .new)
}

// MARK: - APIClientProtocol
extension APIClient: APIClientProtocol {
    
    var productListRequestResponse: Observable<RequestResponse<[Product]>> {
        return productListRequestResponseSubject
            .asObservable()
    }
    
    func getProductList(currentPage: Int)  {
        let path = currentPage == 1 ? APIClient.productFirstPathPage : APIClient.productNextPathPage
        
        guard let url = URL(string: "\(APIClient.baseURLString)\(path)") else {
            productListRequestResponseSubject.onNext(.failure(error: NSLocalizedString("message.error", comment: "")))
            return
        }

        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            guard let data = data else {
                self?.productListRequestResponseSubject.onNext(.failure(error: error?.localizedDescription ?? NSLocalizedString("message.error", comment: "")))
                return
            }

            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                if let productsJson = jsonObj!.value(forKey: "products") as? NSArray {

                    var products = [Product]()
                    for productJson in productsJson {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: productJson, options: .prettyPrinted) else { break }
                        guard let product = try? JSONDecoder().decode(Product.self, from: jsonData) else { break }
                        products.append(product)
                    }

                    if !products.isEmpty {
                        self?.productListRequestResponseSubject.onNext(.success(object: products))

                    } else {
                        self?.productListRequestResponseSubject.onNext(.failure(error: NSLocalizedString("message.error", comment: "")))
                    }
                }
            }
            }.resume()
    }
}
