//
//  ItunesResponse.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

struct ItunesResponse<T: Decodable>: Decodable {
    
    let resultCount: Int
    let results: T
    
}
