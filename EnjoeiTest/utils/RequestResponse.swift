//
//  RequestResponse.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 19/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

enum RequestResponse<T> {
    case new
    case loading
    case success(object: T)
    case failure(error: String)
}
