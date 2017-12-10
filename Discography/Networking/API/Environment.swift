//
//  Environment.swift
//  Discography
//
//  Created by Dario Fanjul on 05/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

protocol Environment {
    
    var scheme: String { get }
    var host: String { get }
    
}

struct DevelopmentEnvironment: Environment {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "itunes.apple.com"
    }
    
}
