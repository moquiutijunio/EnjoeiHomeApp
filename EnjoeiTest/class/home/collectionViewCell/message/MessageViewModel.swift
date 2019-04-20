//
//  MessageViewModel.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 20/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift

protocol MessageViewModelCallbackProtocol: AnyObject {
    
    func tryAgain()
}

class MessageViewModel: NSObject {
    
    private let _title: String
    private weak var callback: MessageViewModelCallbackProtocol?
    
    init(title: String, callback: MessageViewModelCallbackProtocol?) {
        self._title = title
        super.init()
        self.callback = callback
    }
}

extension MessageViewModel: MessageCollectionViewModelProtocol {
    
    var title: Observable<String> {
        return .just(_title)
    }
    
    func tryAgainTapped() {
        callback?.tryAgain()
    }
}
