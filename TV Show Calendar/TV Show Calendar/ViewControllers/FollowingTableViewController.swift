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
            let curr = TvShowModel(id: tvShow.id!, imagePath: tvShow.imagePath, backDropPath: tvShow.backDropPath, name: tvShow.name!, description: tvShow.tvDescription, rating: tvShow.rating)
            tvShows.append(curr)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TvShowVC") as! TvShowViewController
        
        nextVC.tvShow = self.tvShows[indexPath.row]
        
        self.show(nextVC, sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = tableView.backgroundColor
        let tvShow = tvShows[indexPath.row]
        cell.imageView?.setImageFromUrl(imageUrl: URL(string: tvShow.imagePath!)!)
        cell.textLabel?.text = tvShow.name

        return cell
    }
    
}
