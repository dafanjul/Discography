//
//  Artist.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

struct Artist: Decodable {
    
    let artistName: String
    let artistId: Int
    let primaryGenreName: String?
    
}
