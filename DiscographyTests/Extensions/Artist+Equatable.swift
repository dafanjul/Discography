//
//  Artist+Equatable.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation
@testable import Discography

extension Artist: Equatable {}

public func ==(lhs: Artist, rhs: Artist) -> Bool {
    return lhs.artistId == rhs.artistId &&
        lhs.artistName == rhs.artistName &&
        lhs.primaryGenreName == rhs.primaryGenreName
}
