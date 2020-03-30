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
    
    var foods: [[FoodInfo]] = []

    var response1: [FoodInfo] = []
    var response2: [FoodInfo] = []
    var response3: [FoodInfo] = []
    
    var numberOfRow: Int {
        return foods.count
    }
            
    func fetchAllFood(completion :@escaping (() -> ()) ) {
        userProvider.request(.foodRequest(term: "pasta")) { (result) in
            switch result {
            case .success(let response):
                do {
                  let result = try JSONDecoder().decode(Meal.self, from: response.data)
                    
                    self.response1 = result.businesses
                    self.foods.append(self.response1)
                    self.requestAllFood2(completion: completion)
//                  completion()
                  
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestAllFood2(completion :@escaping (() -> ()) ) {
          userProvider.request(.foodRequest(term: "pototoes")) { (result) in
                    switch result {
                    case .success(let response):
                        do {
                          let result = try JSONDecoder().decode(Meal.self, from: response.data)
                            
                          self.response2 = result.businesses
                          self.foods.append(self.response2)
                          self.requestAllFood3(completion: completion)
                            
                        } catch {
                            print(error)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
    func requestAllFood3(completion :@escaping (() -> ()) ) {
          userProvider.request(.foodRequest(term: "seafood")) { (result) in
                    switch result {
                    case .success(let response):
                        do {
                          let result = try JSONDecoder().decode(Meal.self, from: response.data)
                          self.response3 = result.businesses
                          self.foods.append(self.response3)
                          
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
