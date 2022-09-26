//
//  MarketViewModel.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 22.09.2022.
//

import Foundation
import UIKit


class MarketViewModel {
    var result : [Data] = []
    
    func nib(colView: UICollectionView) {
        let nibData = UINib(nibName: "CollectionViewCell", bundle: nil)
        colView.register(nibData, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK: - DELEGATES FUNCTİONS CONFİGURE
    func added(id: String,col : UICollectionView) -> [Data]{
        for i in 0...result.count{
            if result[i].id == id {
                result[i].addedCount! += 1
                break
            }
        }
        col.reloadData()
        return result
    }
    
    func deleted(id: String, cv: UICollectionView) -> [Data] {
        for i in 0...result.count{
            if result[i].id == id {
                result[i].addedCount! -= 1
                if result[i].addedCount == 0 {
                    result[i].isBasket = nil
                }
                break
            }
        }
        cv.reloadData()
        return result
    }
    
    func basketAddedProduct(index : Int) -> [Data] {
        var vc = ViewController()
        if result[index].isBasket != true {
            self.result[index].isBasket = true
            self.result[index].addedCount = 1
        }
        else {
            self.result[index].addedCount! += 1
            if result[index].addedCount != 0 {
                let totalPrice = (Double(result[index].price ?? 0) * Double(result[index].addedCount ?? 0))
                vc.totalPrice = "\(totalPrice)"
            }
        }
        return result
    }
    
    func basketDeletedProduct(index: Int) -> [Data] {
      //  var vc = ViewController()
        if result[index].addedCount == 1 {
            result[index].isBasket = false
        }
        else if result[index].addedCount! > 0{
            self.result[index].addedCount! -= 1
        }
        return result
    }
    func basketClear(cv: UICollectionView) ->[Data] {
        for i in 0...result.count-1 {
            self.result[i].addedCount = 0
            self.result[i].isBasket = nil
        }
        return result
    }
    
  

}
    

