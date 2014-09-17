//
//  MoviesViewController.swift
//  ReallyRottenTomatoes
//
//  Created by Harsha Vashisht on 9/10/14.
//  Copyright (c) 2014 Harsha Vashisht. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkDownLabel: UILabel!
    @IBOutlet weak var networkUIView: UIView!
    var movies : [NSDictionary] = []
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.networkDownLabel.hidden = true
        //self.networkUIView.hidden = true
        
        //Loading screen
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), {
            self.loadData()
            dispatch_async(dispatch_get_main_queue(), {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                return
            })
        })
        
        self.refreshControl = UIRefreshControl()
        var refreshString = NSMutableAttributedString(string: "Pull down to refersh")
        self.refreshControl.attributedTitle = refreshString
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
    }

    
    func refresh() {
        loadData()
    }
    
    func loadData() {
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?page_limit=20&page=1&country=us&apikey=bprs5jym5nmu4srh24amxpjg"
        var request = NSURLRequest(URL: NSURL(string: url))
        fetchApiData(request)
    }
    
    func fetchApiData(request: NSURLRequest) {
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()
            ) { (response: NSURLResponse!, data:NSData!, error:NSError!) -> Void in
                
                if error == nil {
                    var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                    self.movies = object["movies"] as [NSDictionary]
                    self.tableView.reloadData()
                } else {
                    self.networkDownLabel.hidden = false
                    println("Error in getting data \(error)")
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("I'm at row: \(indexPath.row), section: \(indexPath.section)")
    
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        var movie = movies[indexPath.row] as NSDictionary
        
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        //println(posterUrl)
        if (!posterUrl.isEmpty) {
            cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        
        }
        return cell
    }
    
    
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("Coming Here")
        if segue.identifier == "movieSegue"{
            let vc = segue.destinationViewController as MovieDetailViewController
            
            var rowClicked = tableView.indexPathForSelectedRow()!.row
            vc.movie = movies[rowClicked] as NSDictionary
            self.view.endEditing(true);
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
