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

class MessageViewModel: NSObject, MessageCollectionViewModelProtocol {
    
    let title: String
    private weak var callback: MessageViewModelCallbackProtocol?
    
    init(title: String, callback: MessageViewModelCallbackProtocol?) {
        self.title = title
        super.init()
        self.callback = callback
    }
    
    func tryAgainTapped() {
        callback?.tryAgain()
    }
}
