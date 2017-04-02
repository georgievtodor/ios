//
//  FollowingTableViewController.swift
//  TV Show Calendar
//
//  Created by Todor on 4/2/17.
//  Copyright © 2017 Todor. All rights reserved.
//

import UIKit

class FollowingTableViewController: UITableViewController {
    let reuseIdentifier = "Following Cell"
    var data: LocalData?
    var tvShows = [TvShowModelDelegate]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvShows = [TvShowModelDelegate]()
        data = LocalData()
        tableView.dataSource = self
        let followingTvShows = data?.getAll()
        followingTvShows?.forEach {
            tvShow in
            let curr = TvShowModel(id: tvShow.id!, imagePath: tvShow.imagePath, backDropPath: tvShow.backDropPath, name: tvShow.name!, description: tvShow.description, rating: tvShow.rating)
            tvShows.append(curr)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tvShows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let tvShow = tvShows[indexPath.row]
        cell.imageView?.setImageFromUrl(imageUrl: URL(string: tvShow.imagePath!)!)
        cell.textLabel?.text = tvShow.name

        return cell
    }
    
}
