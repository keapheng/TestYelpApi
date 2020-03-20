//
//  FoodTableViewCell.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/20/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var mealCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mealCollectionView.dataSource = self
        mealCollectionView.delegate = self
        
        self.mealCollectionView.register(UINib(nibName: "MealCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mealCollectionCell")
    }

}

extension FoodTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: "mealCollectionCell", for: indexPath) as? MealCollectionViewCell
            else { return UICollectionViewCell() }
        
        
        return cell
    }
    
}

extension FoodTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.mealCollectionView.frame.width / 1.3, height: self.mealCollectionView.frame.height)
    }
}
