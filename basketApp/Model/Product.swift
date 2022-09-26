//
//  Product.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 15.09.2022.
//

import Foundation

struct Product: Codable {
    let data: [Data]
}

struct Data: Codable {
    let id: String?
    let name: String?
    let price: Double?
    let currency: String?
    let imageUrl: String?
    let stock: Int?
    var isBasket: Bool? = nil
    var addedCount : Int? = 0
    
}

