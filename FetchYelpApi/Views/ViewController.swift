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
    
//    var spinner = UIActivityIndicatorView(style: .large)
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .ballSpinFadeLoader, color: .gray, padding: nil)

    let foodPresenter = FoodPresenter()
    var screenView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
        self.startSpinner()
        searchBar.delegate = self
        
        foodPresenter.fetchAllFood(foodTerm: "pasta") { [weak self] in
            guard let this = self else { return }
            this.foodTableView.reloadData()
            this.stopSpinner()
        }
        
    }

    func startSpinner() {
        screenView = UIView(frame: UIScreen.main.bounds)
        screenView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        activityIndicatorView.center = self.view.center
        self.navigationController?.view.addSubview(screenView!)
        screenView?.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
    }
    
    func stopSpinner() {
        screenView?.removeFromSuperview()
        activityIndicatorView.stopAnimating()
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
        startSpinner()
        foodPresenter.foods = []
        foodPresenter.fetchAllFood(foodTerm: searchBar.text!) { [weak self] in
            guard let this = self else { return }
            this.foodTableView.reloadData()
            this.stopSpinner()
        }
        searchBar.text = ""
        searchBar.endEditing(true)
        
    }
    
}
