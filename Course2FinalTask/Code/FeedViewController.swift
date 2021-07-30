//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 26.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedViewController: UIViewController {
    @IBOutlet weak var feedTableView: UITableView! {
        didSet {
            feedTableView.delegate = self
            feedTableView.dataSource = self
            feedTableView.allowsSelection = false
        }
    }
    var posts: [Post] = [] {
        didSet {
            feedTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = DataProviders.shared.postsDataProvider.feed()
    }
}

extension FeedViewController: UITableViewDelegate {

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        feedCell.configure(post: posts[indexPath.row], delegate: self)
        return feedCell
    }
}

extension FeedViewController: FeedTableViewCellDelegate {
    func updatePosts() {
        posts = DataProviders.shared.postsDataProvider.feed()
    }
    
    func pushProfileViewController(withUserId id: User.Identifier) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.userId = id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushUserListViewController(withIds ids: [User.Identifier]) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        vc.usersIds = ids
        navigationController?.pushViewController(vc, animated: true)
    }
}
