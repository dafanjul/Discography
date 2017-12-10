//
//  MockImageDownloader.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation
@testable import Discography

class MockImageDownloader: ImageDownloaderType {
    
    var urlReceived: URL?
    var completionReceived: ((Data?, Error?) -> Void)?
    var downloadImageDataCalled = false
    
    func downloadImageData(with url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask? {
        urlReceived = url
        completionReceived = completion
        downloadImageDataCalled = true
        
        return MockURLSessionDataTask()
    }
    
}
