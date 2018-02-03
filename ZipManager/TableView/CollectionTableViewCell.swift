//
//  CollectionTableViewCell.swift
//  ZipManager
//
//  Created by Chris Mauldin on 1/31/18.
//  Copyright © 2018 Chris Mauldin. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collageOfImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
