//
//  WebService.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 15.09.2022.
//

import Foundation


class WebService {
    func getData(url: URL, completion:@escaping ([Data]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let productList = try? JSONDecoder().decode(Product.self, from: data)
                if let productList = productList {
                    completion(productList.data)
                }
            }
        }.resume()
    }
    func getCheck(url: URL, completion:@escaping (DataClass?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let checkList = try? JSONDecoder().decode(Check.self, from: data)
                if let checkList = checkList {
                    completion(checkList.data)
                }
            }
        }.resume()
    }
}
