//
//  ViewController.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/20/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {

    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let foodPresenter = FoodPresenter()
    var screenView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
        self.startActivityIndicator()
        searchBar.delegate = self
        
        foodPresenter.fetchAllFood(foodTerm: "pasta") { [weak self] in
            guard let this = self else { return }
            this.foodTableView.reloadData()
            this.stopActivityIndicator()
        }
        
    }

//    func startSpinner() {
//        screenView = UIView(frame: UIScreen.main.bounds)
//        screenView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        activityIndicatorView.center = self.view.center
//        self.navigationController?.view.addSubview(screenView!)
//        screenView?.addSubview(activityIndicatorView)
//        activityIndicatorView.startAnimating()
//
//    }
    
//    func stopSpinner() {
//        screenView?.removeFromSuperview()
//        activityIndicatorView.stopAnimating()
//    }
    
    func startActivityIndicator() {
        NVActivityIndicatorView.DEFAULT_TYPE = .lineScalePulseOut
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopActivityIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    func setUpTableView() {
        foodTableView.delegate = self
        foodTableView.dataSource = self
        self.foodTableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "foodTableCell")
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodPresenter.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = foodTableView.dequeueReusableCell(withIdentifier: "foodTableCell", for: indexPath) as? FoodTableViewCell
            else { return UITableViewCell() }

        cell.foodPresenter = foodPresenter
        
        // Here what I have changed
        cell.didSelectItemAction = { [weak self] image, foodName, rating, reviewCount in
            
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailView") as DetailViewController
            detailVC.imageDetail = image
            detailVC.name = foodName
            detailVC.rating = rating
            detailVC.review = reviewCount
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.foodTableView.frame.height / 2.8
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startActivityIndicator()
        foodPresenter.foods = []
        foodPresenter.fetchAllFood(foodTerm: searchBar.text!) { [weak self] in
            guard let this = self else { return }
            this.foodTableView.reloadData()
            this.stopActivityIndicator()
        }
        searchBar.text = ""
        searchBar.endEditing(true)
        
    }
    
}
