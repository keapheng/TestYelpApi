//
//  Meal.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/20/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import Foundation

struct Meal: Decodable {
    var businesses: [FoodInfo]
}

struct FoodInfo: Decodable {
    var name: String
    var image_url: String
    var review_count: Int
    var rating: Float
}
