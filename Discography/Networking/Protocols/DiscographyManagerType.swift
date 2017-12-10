//
//  DiscographyManagerType.swift
//  Discography
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

protocol DiscographyManagerType {
    
    func requestDiscography(for artistId: Int, completion: @escaping ([Album]?, Error?) -> Void)
    func cancelAllRequests()
    func cancelRequest(for artistId: Int)
    
}
