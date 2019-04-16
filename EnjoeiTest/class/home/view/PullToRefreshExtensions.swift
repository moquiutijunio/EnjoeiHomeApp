//
//  PullToRefreshExtensions.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import Cartography
import INSPullToRefresh

extension UIScrollView {
    
    func addPullToRefreshToScrollView(handler: @escaping (UIScrollView) -> Void) {
        let pullToRefreshView = PullToRefreshView.instantiateFromNib()
        
        ins_addPullToRefresh(withHeight: pullToRefreshView.frame.height) { [weak self] (scrollView) -> Void in
            guard let strongSelf = self else { return }
            handler(strongSelf)
        }
        
        ins_pullToRefreshBackgroundView.delegate = pullToRefreshView
        ins_pullToRefreshBackgroundView.addSubview(pullToRefreshView)
        constrain(ins_pullToRefreshBackgroundView, pullToRefreshView) { (pullToRefreshBackgroundView, pullToRefreshView) -> () in
            pullToRefreshView.edges == pullToRefreshBackgroundView.edges
        }
    }
    
    func addInfinityScrollRefreshView(handler: @escaping (UIScrollView) -> Void) {
        let infinityScrollRefreshView = InfinityScrollRefreshView.instantiateFromNib()
        
        ins_addInfinityScroll(withHeight: infinityScrollRefreshView.frame.height) { [weak self] (scrollView) -> Void in
            guard let strongSelf = self else { return }
            handler(strongSelf)
        }
        
        ins_infiniteScrollBackgroundView.delegate = infinityScrollRefreshView
        ins_infiniteScrollBackgroundView.addSubview(infinityScrollRefreshView)
        constrain(ins_infiniteScrollBackgroundView, infinityScrollRefreshView) { (infiniteScrollBackgroundView, infinityScrollRefreshView) -> () in
            infinityScrollRefreshView.edges == infiniteScrollBackgroundView.edges
        }
    }
}
