//
//  FeedViewController.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 26.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView! {
        didSet {
            feedTableView.delegate = self
            feedTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension FeedViewController: UITableViewDelegate {
    
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        return feedCell
    }
}
