//
//  MovieDetailViewController.swift
//  ReallyRottenTomatoes
//
//  Created by Harsha Vashisht on 9/16/14.
//  Copyright (c) 2014 Harsha Vashisht. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: NSDictionary?
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println(self.movie)
        var movieTitle = self.movie!["title"] as? String
        self.movieTitleLabel.text = movieTitle
        self.movieSynopsisLabel.text = self.movie!["synopsis"] as? String
        self.movieSynopsisLabel.sizeToFit()
        let posters = self.movie!["posters"] as NSDictionary
        let posterUrl = posters["thumbnail"] as String
        self.posterImageView.setImageWithURL(NSURL(string: posterUrl))
        let imgUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        self.navigationItem.title = movieTitle
        
        posterImageView.setImageWithURL(NSURL(string: imgUrl))
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
