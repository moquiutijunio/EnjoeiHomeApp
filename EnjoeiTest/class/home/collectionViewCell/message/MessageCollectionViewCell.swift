//
//  MessageCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift

protocol MessageCollectionViewModelProtocol {
    
    var title: Observable<String> { get }
    func tryAgainTapped()
}

class MessageCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    private var disposeBag: DisposeBag!
    private var viewModel: MessageCollectionViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        
        messageLabel.font = UIFont.proximaNovaRegular(ofSize: 14)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .gray2
        messageLabel.numberOfLines = 0
        
        tryAgainButton.setTitle(NSLocalizedString("try.again", comment: ""), for: .normal)
        tryAgainButton.setTitleColor(.white, for: .normal)
        tryAgainButton.layer.cornerRadius = 4
        tryAgainButton.clipsToBounds = true
        tryAgainButton.titleLabel?.font = UIFont.proximaNovaRegular(ofSize: 14)
        tryAgainButton.backgroundColor = .primaryColor
    }
    
    func bindIn(viewModel: MessageCollectionViewModelProtocol) {
        disposeBag = DisposeBag()
        
        viewModel.title
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
        
        tryAgainButton.rx.tap
            .bind { viewModel.tryAgainTapped() }
            .disposed(by: disposeBag)
        
        self.viewModel = viewModel
    }
}
