//
//  ImageCell.swift
//  Happy Campers
//
//  Created by axMxe on 8/30/18.
//  Copyright © 2018 axMxe. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var happyImg: UIImageView!
    
    func configureCell(image: Image) {
        happyImg = image.image
    }
}
