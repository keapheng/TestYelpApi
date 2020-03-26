//
//  ViewController.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/20/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var foodTableView: UITableView!
    let spinner = UIActivityIndicatorView(style: .large)
    let foodPresenter = FoodPresenter()
    var screenView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTableView()
        self.startSpinner()
        
        foodPresenter.fetchAllFood { [weak self] in
            guard let this = self else { return }
            this.foodTableView.reloadData()
            this.stopSpinner()
        }

        
    }

    func startSpinner() {
        screenView = UIView(frame: self.view.bounds)
        screenView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        spinner.center = self.view.center
        self.view.addSubview(screenView!)
        self.view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        screenView?.removeFromSuperview()
        spinner.stopAnimating()
    }

    func setUpTableView() {
        foodTableView.delegate = self
        foodTableView.dataSource = self
        self.foodTableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "foodTableCell")
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodPresenter.foods.count
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
