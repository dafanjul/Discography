//
//  ItunesAlbumResponse.swift
//  Discography
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

struct ItunesAlbumResponse: Decodable {
    
    let resultCount: Int
    let results: [Album]
    
    private enum CodingKeys: String, CodingKey {
        case results
        case resultCount
    }
    
    private enum NestedCodingKeys: String, CodingKey {
        case wrapperType
    }
    
    private enum SupportedElements: String, Decodable {
        case collection
        case artist
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decode(Int.self, forKey: .resultCount)
        var albumData = try values.nestedUnkeyedContainer(forKey: .results)
        var returnedElements = albumData
        var albums = [Album]()
        while !returnedElements.isAtEnd {
            let element = try returnedElements.nestedContainer(keyedBy: NestedCodingKeys.self)
            let elementType = try element.decode(SupportedElements.self, forKey: .wrapperType)
            switch elementType {
            case .artist:
                _ = try albumData.decode(Artist.self)
            case .collection:
                albums.append(try albumData.decode(Album.self))
            }
        }
        results = albums
    }
    
}
