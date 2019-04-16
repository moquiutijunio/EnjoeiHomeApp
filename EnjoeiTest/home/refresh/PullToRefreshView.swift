//
//  PullToRefreshView.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import INSPullToRefresh

class PullToRefreshView: UIView {
    
    class func instantiateFromNib() -> PullToRefreshView {
        return Bundle.main.loadNibNamed("PullToRefreshView", owner: self, options: nil)?.first as! PullToRefreshView
    }
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    private func startAnimating() {
        let image = UIImage.gifImageWithName("reload")
        gifImageView.image = image
    }
    
    private func stopAnimating() {
        gifImageView.image = nil
    }
}

extension PullToRefreshView: INSPullToRefreshBackgroundViewDelegate {
    func pull(_ pullToRefreshBackgroundView: INSPullToRefreshBackgroundView!, didChange state: INSPullToRefreshBackgroundViewState) {
        switch state {
        case .none:
            stopAnimating()

        case .loading:
            startAnimating()

        case .triggered:
            stopAnimating()

        }
    }
}