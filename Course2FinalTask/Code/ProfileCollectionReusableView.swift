//
//  ProfileCollectionReusableView.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 30.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

protocol ProfileCollectionReusableViewDelegate {
    func pushUserListViewController(with users: [User], vcTitle: String)
}

class ProfileCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        }
    }
    @IBOutlet weak var fullUserNameLabel: UILabel!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    private var delegate: ProfileCollectionReusableViewDelegate!
    private var user: User!
    
    func configure(user: User, delegate: ProfileCollectionReusableViewDelegate) {
        self.user = user
        self.delegate = delegate
        avatarImageView.image = user.avatar
        fullUserNameLabel.text = user.fullName
        followersButton.setTitle("Followers: \(user.followedByCount)", for: .normal)
        followingButton.setTitle("Following: \(user.followsCount)", for: .normal)
    }
    
    @IBAction func followersButtonPressed() {
        let users = DataProviders.shared.usersDataProvider.usersFollowingUser(with: user.id) ?? []
        delegate.pushUserListViewController(with: users, vcTitle: "Followers")
    }
    
    @IBAction func followingButtonPressed() {
        let users = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: user.id) ?? []
        delegate.pushUserListViewController(with: users, vcTitle: "Following")
    }
}
