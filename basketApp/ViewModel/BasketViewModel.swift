//
//  BasketViewModel.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 22.09.2022.
//

import Foundation
import UIKit
import simd

class BasketViewModel {
    
    var delegate : MarketViewControllerDelegate?
    
    var result : [Data] = []
    //var check : Check?
    func alert(message : String,title: String, vc: BasketViewController) {
       
    }
    func filter(result: [Data]) -> ([Data]){
        let filtered = result.filter{$0.isBasket == true}
        return (filtered)
    }
   
    func countIncrement(id: String) -> [Data]{
        for i in 0...result.count{
            if (result[i].id == id) {
                result[i].addedCount! -= 1
                break
            }
        }
        return result
    }
    
    func countAdded(id: String) -> [Data] {
        for i in 0...result.count{
            if (result[i].id == id) {
                result[i].addedCount! += 1
                break
            }
        }
        return result
    }
    /*
    func basketCheck(tbl: UITableView,check :String) -> (UIViewController,UIViewController) {
        let alert = UIAlertController(title: "Sepet Onayı" , message: "Sepeti Onaylıyor Musunuz?", preferredStyle: UIAlertController.Style.alert)
        let alert2 = UIAlertController(title: "Succesfully", message: check, preferredStyle: UIAlertController.Style.alert)

        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
            self.delegate?.removeAllBasket(data: self.result)
            self.result.removeAll()
            tbl.reloadData()
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert2.addAction(okButton)
           
        }
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        return (alert,alert2)
    }
     */
    
    
}

