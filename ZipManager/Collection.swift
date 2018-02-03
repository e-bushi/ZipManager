//
//  Collection.swift
//  ZipManager
//
//  Created by Chris Mauldin on 1/22/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import Foundation



struct Collection {
    var collectionName: String
    var zipUrl: String
    var unzippedUrl: URL?
}

extension Collection: Decodable {
    
    enum collectionKeys: String, CodingKey {
        case collectionName = "collection_name"
        case zippedUrl = "zipped_images_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: collectionKeys.self)
        
        let name = try container.decode(String.self, forKey: .collectionName)
        
        let images = try container.decode(String.self, forKey: .zippedUrl)
        
        self.init(collectionName: name, zipUrl: images, unzippedUrl: nil)
    }
}
