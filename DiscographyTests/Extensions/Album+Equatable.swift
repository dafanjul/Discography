//
//  Album+Equatable.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation
@testable import Discography

extension Album: Equatable {}
    
public func ==(lhs: Album, rhs: Album) -> Bool {
    return lhs.coverURL == rhs.coverURL &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.year == rhs.year &&
        lhs.collectionName == rhs.collectionName
}

