//
//  MockURLSessionDataTask.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    var resumeCalled = false
    
    override func resume() {
        resumeCalled = true
    }
    
}
