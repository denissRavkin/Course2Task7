//
//  UserListViewController.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 28.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class UserListViewController: UIViewController {
    @IBOutlet weak var userListTableView: UITableView! {
        didSet {
            userListTableView.delegate = self
            userListTableView.dataSource = self
            userListTableView.rowHeight = 45
        }
    }
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListTableView.reloadData()
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.configure(user: users[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.userId = users[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}


