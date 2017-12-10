//
//  URLQueryItems+Utils.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

extension Array where Element == URLQueryItem {
    
    func valueFor(key: String) -> String? {
        return self.filter({$0.name == key}).first?.value
    }
    
}
