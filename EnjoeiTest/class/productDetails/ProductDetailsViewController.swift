//
//  ProductDetailsViewController.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    let currentProduct: Product
    
    init(product: Product) {
        self.currentProduct = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        updateBackBarButton()
    }
    
    private func updateBackBarButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_back")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
