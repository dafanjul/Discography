//
//  Album.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    let collectionName: String
    let releaseDate: String
    let coverURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case collectionName
        case releaseDate
        case coverURL = "artworkUrl100"
    }
    
    var year: Int? {
        if let date = Album.dateFormatter.date(from: releaseDate) {
            return Calendar.current.component(.year, from: date)
        }
        return nil
    }
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
}
