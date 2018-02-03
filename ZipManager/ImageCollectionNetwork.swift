//
//  ImageCollectionNetwork.swift
//  ZipManager
//
//  Created by Chris Mauldin on 1/23/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import Foundation
import Alamofire
import Zip

class CollectionNetwork {
    
    let fileSystem = FileManager.default
    var zipPaths = [String]()
    var fileDestination: DownloadRequest.DownloadFileDestination?
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/mob3/image_collection.json"
    
    func fetch(callback: @escaping ([Collection]) -> Void) {
        
        Alamofire.request(baseUrl).responseJSON { response in
            do {
                let collections = try JSONDecoder().decode([Collection].self, from: response.data!)
                
                callback(collections)
            } catch {
                print("Network Session Failure")
            }
        }
    }
}
