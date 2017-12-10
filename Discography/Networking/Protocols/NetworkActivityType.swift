//
//  NetworkActivityType.swift
//  Discography
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

protocol NetworkActivityType {
    
    static func startedRequest()
    static func stoppedRequest()
    
}
