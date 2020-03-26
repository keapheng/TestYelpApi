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
    
//    var foods: [FoodInfo] = []
    
    
    var response1: [FoodInfo] = []
    var response2: [FoodInfo] = []
    var response3: [FoodInfo] = []
            
    func fetchAllFood(completion :@escaping (() -> ()) ) {
        userProvider.request(.foodRequest(term: "pasta")) { (result) in
            switch result {
            case .success(let response):
                do {
                  let result = try JSONDecoder().decode(Meal.self, from: response.data)

//                  self.foods = result.businesses
                    
                  self.response1 = result.businesses
                    self.foods.append(self.response1)
                                
                  completion()
                  
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        userProvider.request(.foodRequest(term: "pototoes")) { (result) in
                    switch result {
                    case .success(let response):
                        do {
                          let result = try JSONDecoder().decode(Meal.self, from: response.data)

                            
                          self.response2 = result.businesses
                            self.foods.append(self.response2)
                                        
                          completion()
                          
                        } catch {
                            print(error)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
        }
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
