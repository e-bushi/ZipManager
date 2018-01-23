//
//  Collection.swift
//  ZipManager
//
//  Created by Chris Mauldin on 1/22/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import Foundation

struct CollectionList: Decodable {
    var list: [Collection]
}

struct Collection {
    var collectionName: String
    var zip_url: String
}

extension Collection: Decodable {
    
    enum collectionKeys: String, CodingKey {
        case collection_name
        case zipped_images_url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: collectionKeys.self)
        
        let name = try container.decode(String.self, forKey: .collection_name)
        
        let images = try container.decode(String.self, forKey: .zipped_images_url)
        
        self.init(collectionName: name, zip_url: images)
    }
}
