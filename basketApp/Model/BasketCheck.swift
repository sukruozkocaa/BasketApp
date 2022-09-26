//
//  BasketCheck.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 23.09.2022.
//

import Foundation


struct Check: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let message: String?
}
