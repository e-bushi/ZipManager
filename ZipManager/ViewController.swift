//
//  ViewController.swift
//  ZipManager
//
//  Created by Chris Mauldin on 1/22/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import UIKit
import Alamofire
import Zip

class ViewController: UIViewController {
    
    
    var list = [Collection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fileManager = FileManager.default
        let tempPath = fileManager.temporaryDirectory
        
        Alamofire.download(<#T##urlRequest: URLRequestConvertible##URLRequestConvertible#>, to: <#T##DownloadRequest.DownloadFileDestination?##DownloadRequest.DownloadFileDestination?##(URL, HTTPURLResponse) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions)#>)
        Alamofire.request("https://s3-us-west-2.amazonaws.com/mob3/image_collection.json").responseJSON { (response) in
            DispatchQueue.main.async {
                do {
                    let collection = try JSONDecoder().decode([Collection].self, from: response.data!)
                    
                } catch {

                }

            }
        }
        
        
    }

}


extension ViewController {
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
}

