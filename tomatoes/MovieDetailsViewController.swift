//
//  MovieDetailsViewController.swift
//  tomatoes
//
//  Created by Sid Reddy on 9/14/14.
//  Copyright (c) 2014 Sid Reddy. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    var movie: NSDictionary! = [:]
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem?.title = "Movies"
        
        // Set navigation header, and title
        var title = movie["title"] as? String
        self.navigationItem.title = title
        self.navigationItem.hidesBackButton = false        
        
        // Set poster
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["detailed"] as NSString
        posterUrl = posterUrl.stringByReplacingOccurrencesOfString("_tmb", withString: "_org")
        posterImage.setImageWithURL(NSURL(string: posterUrl))
        posterImage.clipsToBounds = true
        
        // Set title
        titleLabel.text = title
        
        // Set rating
        var ratings = movie["ratings"] as NSDictionary
        var critics_score: Int! = ratings["critics_score"] as Int
        var audience_score: Int! = ratings["audience_score"] as Int
        ratingLabel.text = "Critics Score: \(critics_score), Audience Score: \(audience_score)"
        
        // Set synopsis
        synopsisTextView.editable = false
        synopsisTextView.text = movie["synopsis"] as? String
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
