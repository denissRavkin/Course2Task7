//
//  FeedTableViewCell.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 26.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

protocol FeedTableViewCellDelegate {
    func pushUserListViewController(withIds ids: [User.Identifier])
    func pushProfileViewController(withUserId id: User.Identifier)
    func updatePosts()
}

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    @IBOutlet weak var userAvatar: UIImageView!{
        didSet {
            userAvatar.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarOrUserName))
            userAvatar.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarOrUserName))
            nameLabel.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.isUserInteractionEnabled = true
            let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapOnPostImage))
            doubleTapGestureRecognizer.numberOfTapsRequired = 2
            postImageView.addGestureRecognizer(doubleTapGestureRecognizer)
        }
    }
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var bigLikeImageView: UIImageView! {
        didSet {
            bigLikeImageView.layer.opacity = 0
        }
    }
    
    private var post: Post!
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' K:mm:ss aaa"
        return dateFormatter
    }()
    private var delegate: FeedTableViewCellDelegate!
    
    func configure(post: Post, delegate: FeedTableViewCellDelegate) {
        self.delegate = delegate
        self.post = post
        userAvatar.image = post.authorAvatar
        nameLabel.text = post.authorUsername
        dateLabel.text = dateFormatter.string(from: post.createdTime)
        likesButton.setTitle("Likes: \(post.likedByCount)", for: .normal)
        postImageView.image = post.image
        likeButton.tintColor = post.currentUserLikesThisPost ? .systemBlue : .lightGray
        postTextLabel.text = post.description
        let image = #imageLiteral(resourceName: "bigLike").withRenderingMode(.alwaysTemplate)
        likeButton.setImage(image, for: .normal)
    }
    
    @IBAction func likesButtonPressed() {
        let usersIdsLikedThisPost = DataProviders.shared.postsDataProvider.usersLikedPost(with: post.id)
        delegate.pushUserListViewController(withIds: usersIdsLikedThisPost ?? [])
    }
    
    @IBAction func likeButtonPressed() {
        if post.currentUserLikesThisPost {
            if DataProviders.shared.postsDataProvider.unlikePost(with: post.id) {
                likeButton.tintColor = .lightGray
                post.currentUserLikesThisPost = false
                post.likedByCount -= 1
                likesButton.setTitle("Likes: \(post.likedByCount)", for: .normal)
                delegate.updatePosts()
            }
        } else {
            if DataProviders.shared.postsDataProvider.likePost(with: post.id) {
                likeButton.tintColor = UIColor.systemBlue
                post.currentUserLikesThisPost = true
                post.likedByCount += 1
                likesButton.setTitle("Likes: \(post.likedByCount)", for: .normal)
                delegate.updatePosts()
            }
        }
    }
    
    @objc func doubleTapOnPostImage() {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.timingFunctions = [CAMediaTimingFunction(name: .linear),
                                     CAMediaTimingFunction(name: .linear),
                                     CAMediaTimingFunction(name: .easeOut)]
        animation.keyTimes = [0.1, 0.3, 0.6]
        animation.values   = [  1,   1,   0]
        self.bigLikeImageView.layer.add(animation, forKey: nil)
        likeButtonPressed()
    }
    
    @objc func tapOnAvatarOrUserName() {
        delegate.pushProfileViewController(withUserId: post.author)
    }
}
