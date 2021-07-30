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
    @IBOutlet weak var profilePhoto: UIImageView! {
        didSet {
            profilePhoto.layer.cornerRadius = profilePhoto.frame.width / 2
        }
    }
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var followers: UIButton!
    @IBOutlet weak var following: UIButton!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var userId: User.Identifier!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhotosCollectionView()
    }
    
    func setupPhotosCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        photosCollectionView.collectionViewLayout = collectionViewLayout
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserPhotoCollectionViewCell", for: indexPath) as! UserPhotoCollectionViewCell
        cell.configure(photo: #imageLiteral(resourceName: "car1"))
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}


