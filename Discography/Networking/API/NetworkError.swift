//
//  NetworkError.swift
//  Discography
//
//  Created by Dario Fanjul on 05/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidURL
    case serverError(Int?)
}
