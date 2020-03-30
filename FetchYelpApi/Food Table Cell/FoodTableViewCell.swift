//
//  FoodTableViewCell.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/20/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var mealCollectionView: UICollectionView!
    
    var foodPresenter: FoodPresenter! {
        didSet {
            mealCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mealCollectionView.dataSource = self
        mealCollectionView.delegate = self
        self.mealCollectionView.register(UINib(nibName: "MealCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mealCollectionCell")
                
    }

}

extension FoodTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodPresenter.foods[section].count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: "mealCollectionCell", for: indexPath) as? MealCollectionViewCell
            else { return UICollectionViewCell() }
        
        let imageUrl = URL(string: foodPresenter.foods[indexPath.section][indexPath.row].image_url)
        let foodName = foodPresenter.foods[indexPath.section][indexPath.row].name
        let rating = foodPresenter.foods[indexPath.section][indexPath.row].rating
        let reviewCount = foodPresenter.foods[indexPath.section][indexPath.row].review_count
        
        
        cell.foodImageView.kf.indicatorType = .activity  // Add loading indicator kingfisher
        cell.foodImageView.kf.setImage(with: imageUrl)
        cell.foodName.text = foodName
        cell.reviewAndRating.text = "\(rating) Stars, \(reviewCount) Reviews"
        
        return cell
    }
    
}

extension FoodTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.mealCollectionView.frame.width / 1.3, height: self.mealCollectionView.frame.height)
    }
}

