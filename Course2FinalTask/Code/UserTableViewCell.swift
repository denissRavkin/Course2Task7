//
//  UserTableViewCell.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 28.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    func configure(user: User) {
        userName.text = user.username
        userAvatar.image = user.avatar
    }
}
