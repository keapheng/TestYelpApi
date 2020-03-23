//
//  FoodPresenter.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/20/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import Foundation
import Moya


final class FoodPresenter {
    
    let userProvider = MoyaProvider<Food>()
    
    var foods: [FoodInfo] = []
    
    func fetchAllFood(completion :@escaping (() -> ()) ) {
        userProvider.request(.foodRequest) { (result) in
            switch result {
            case .success(let response):
                do {
                  let result = try JSONDecoder().decode(Meal.self, from: response.data)
//                    print(result.businesses)
                  self.foods = result.businesses
                  completion()
                  
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
                
    }

}
