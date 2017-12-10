//
//  XCTestCase+Utils.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import XCTest


// MARK: - Utils
extension XCTestCase {
    
    func generateSuccessResponseFrom(filename: String) -> (jsonData: Data?, response: HTTPURLResponse?)  {
        let jsonURL = Bundle.init(for: type(of: self)).url(forResource: filename, withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        let response = HTTPURLResponse(url: jsonURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (jsonData, response)
    }
}
