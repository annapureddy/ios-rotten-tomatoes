//
//  MoviesViewController.swift
//  tomatoes
//
//  Created by Sid Reddy on 9/13/14.
//  Copyright (c) 2014 Sid Reddy. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    var movies: [NSDictionary]! = []
    let rottenTomatoesURL = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dcguz5v9ksrtrj3v6k8ygbdr&limit=20&country=us"
    var refreshControl: UIRefreshControl! = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup handing for tableView
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do not show the Network Error view
        networkErrorView.hidden = true

        // Setup refresh when user pulls
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Show the loading icon
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        // Show loading icon, and then the results display
        loadRottenTomatoesData(removeTop2Elements: true)
    }
    
    func loadRottenTomatoesData(removeTop2Elements: Bool = false) {
        // Fetch data from Rotten Tomatoes API
        var request = NSURLRequest(URL: NSURL(string: rottenTomatoesURL))
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            if (error != nil) {
                // self.networkErrorLabel.center = self.networkErrorView.center
                self.networkErrorView.hidden = false
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                return
            }
            
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            // Store results in self.movies
            self.movies = object["movies"] as [NSDictionary]
            if (removeTop2Elements) {
                self.movies.removeRange(Range(start: 0, end: 2))
            }
            
            // Reload the table data
            self.tableView.reloadData()

            // Hide the loading icon
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    func onRefresh() {
        // User pulls the tableView, and the data should refresh
        loadRottenTomatoesData()
        self.refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        var cell = sender as MovieCell
        (segue.destinationViewController as MovieDetailsViewController).movie = cell.movie
    }

}

extension MoviesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as MovieCell
      
        var movie = movies[indexPath.row]
        cell.movie = movie
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var thumbnail = posters["thumbnail"] as String
        cell.posterImage.setImageWithURL(NSURL(string: thumbnail))
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
}