//
//  Protocols.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 19.09.2022.
//

import Foundation

//MARKETTE ÜRÜN ADEDİ + VE -
protocol MarketViewControllerDelegate {
    func updateBasket(Index:Int)
    func deleteBasket(Index2: Int)
    func removeAllBasket(data : [Data])
    func update(id : String)
    func update2(id: String)
}

//SEPETTEKİ ÜRÜN ADEDİNİ ARTTIRMA
protocol TableViewCellDelegate {
    func added(id : String,buttonTag: Int)
    func deleted(id: String,buttonTag: Int)
}



