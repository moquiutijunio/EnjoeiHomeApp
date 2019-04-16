//
//  InfinityScrollRefreshView.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import INSPullToRefresh

class InfinityScrollRefreshView: UIView {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicatorView.color = .primaryColor
    }
}

extension InfinityScrollRefreshView: INSInfiniteScrollBackgroundViewDelegate {
    
    func infinityScrollBackgroundView(_ infinityScrollBackgroundView: INSInfiniteScrollBackgroundView!, didChange state: INSInfiniteScrollBackgroundViewState) {
        switch state {
        case .none:
            activityIndicatorView.stopAnimating()
            
        case .loading:
            activityIndicatorView.startAnimating()
            
        }
    }
}

extension InfinityScrollRefreshView {
    
    class func instantiateFromNib() -> InfinityScrollRefreshView {
        return Bundle.main.loadNibNamed("InfinityScrollRefreshView", owner: self, options: nil)?.first as! InfinityScrollRefreshView
    }
}
