//
//  UserPhotoCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 28.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    
    func configure(photo: UIImage) {
        photoView.image = photo
    }
}
