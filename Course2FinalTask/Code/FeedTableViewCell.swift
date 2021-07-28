//
//  FeedTableViewCell.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 26.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
