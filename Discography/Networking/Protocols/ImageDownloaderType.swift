//
//  ImageDownloaderType.swift
//  Discography
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

protocol ImageDownloaderType {
    
    func downloadImageData(with url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask?
    
}
