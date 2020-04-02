//
//  TermViewController.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/24/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    var name = ""
    var rating: Float = 0
    var review: Int = 0
    var imageDetail: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: imageDetail)
        let data = try? Data(contentsOf: url!)
        detailImageView.image = UIImage(data: data!)
        
        foodNameLabel.text = name
        feedbackLabel.text = "\(rating) Stars, \(review) Reviews"
    }

}
