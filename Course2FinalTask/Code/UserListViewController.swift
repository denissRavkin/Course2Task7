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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
//        cell.configure(user: <#T##User#>)
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    
}


