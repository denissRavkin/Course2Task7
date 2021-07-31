//
//  ProfileViewController.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 28.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class ProfileViewController: UIViewController {
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var userId: User.Identifier! {
        didSet {
            if let user = DataProviders.shared.usersDataProvider.user(with: userId) {
                self.user = user
            }
        }
    }
    private var user = DataProviders.shared.usersDataProvider.currentUser()
    private lazy var userPosts = DataProviders.shared.postsDataProvider.findPosts(by: user.id) ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhotosCollectionView()
        self.title = user.username
    }
    
    func setupPhotosCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.headerReferenceSize = CGSize(width: photosCollectionView.frame.size.width, height: 86)
        photosCollectionView.collectionViewLayout = collectionViewLayout
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserPhotoCollectionViewCell", for: indexPath) as! UserPhotoCollectionViewCell
        cell.configure(photo: userPosts[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileCollectionReusableView", for: indexPath) as! ProfileCollectionReusableView
            headerView.configure(user: user, delegate: self)
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
}

extension ProfileViewController: ProfileCollectionReusableViewDelegate {
    func pushUserListViewController(with users: [User], vcTitle: String) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        vc.users = users
        vc.title = vcTitle
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}


