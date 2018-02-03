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
    
    @IBOutlet weak var CollectionTableView: UITableView!
    
    
    var photoCollections = [Collection]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        CollectionNetwork().fetch { (collections) in
            self.photoCollections = collections
            
            
            self.downloadAndUnzip()
        }
        
        CollectionTableView.delegate = self
        CollectionTableView.dataSource = self
        
    }
    
    func downloadAndUnzip() {
        
        let fileManager = FileManager.default
        
        let cacheDirectory = try! fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        var index = 0
        
        for collection in self.photoCollections {
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
            Alamofire.download(collection.zipUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, to: destination).response(completionHandler: { (downloadResponse) in
                
                defer {
                    try? fileManager.removeItem(at: downloadResponse.destinationURL!)
                }
                
                do {
                    Zip.addCustomFileExtension("tmp")
                    
                    
                    try Zip.unzipFile(downloadResponse.destinationURL!, destination: cacheDirectory, overwrite: true, password: nil)
                    
                    let fileName = downloadResponse.destinationURL!.deletingPathExtension().lastPathComponent.replacingOccurrences(of: "+", with: "")
                    
                    
                    
                    let UnzippedUrl = cacheDirectory.appendingPathComponent(fileName)
                    
                    
                    
                    self.photoCollections[index].unzippedUrl = UnzippedUrl
                    
                    
                    
                    //                    print("\(self.photoCollections[index])" + "\n")
                    
                    index += 1
                    
                    
                    DispatchQueue.main.async {
                        self.CollectionTableView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
                
            })
        
        }
    }
    
    
    func loadImage(fileUrl: URL?) -> UIImage? {
        do {
            
            guard let fileurl = fileUrl else {return nil}
            
            let imageData = try Data(contentsOf: fileurl)
            
            
            return UIImage(data: imageData)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! CollectionTableViewCell
        
        
        if let url = photoCollections[indexPath.row].unzippedUrl?.appendingPathComponent("_preview.png") {
//            print("\(url)\n\n")
            cell.collageOfImages.image = loadImage(fileUrl: url)
        }

    
        return cell
    }
    
    
    
    
    
    
}



