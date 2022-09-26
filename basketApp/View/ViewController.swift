//
//  ViewController.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 15.09.2022.
//

import UIKit
import Kingfisher



class ViewController: UIViewController{
    @IBOutlet var collectionView: UICollectionView!
    
    private let marketVM = MarketViewModel()
    
    var result : [Data] = []
    var totalPrice: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marketVM.nib(colView: collectionView)
        getData()
      
        
        let logo = UIImage(named: "shop.png")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: logo, style: UIBarButtonItem.Style.plain, target: self, action: #selector(getButton))
        navigationController?.navigationBar.barTintColor = UIColor.systemOrange
        navigationController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
    }
    
    
    
    @objc func getButton() {
        performSegue(withIdentifier:"basket", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "basket"{
            let basketVC = segue.destination as? BasketViewController
            basketVC?.delegate = self
            basketVC?.result = result
            basketVC?.totalPrice = self.totalPrice
        }
    }

    func getData(){
        let url = URL(string: "https://i.tmgrup.com.tr/mulakat/get-liste.json")
        WebService().getData(url: url!) { data in
            if let data = data {
                self.result = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
extension ViewController :  UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.delegate = self
        let productVM = result[indexPath.row]
        cell.set(product: productVM, tag: indexPath.row)
        return cell
    }
    
}
extension ViewController: MarketViewControllerDelegate {
    func removeAllBasket(data: [Data]) {
        self.marketVM.result = data
        result = marketVM.basketClear(cv: collectionView)
        self.collectionView.reloadData()
    }

    
    func update(id: String) {
        marketVM.result = result
        result = marketVM.added(id: id, col: collectionView)
    }
    func update2(id: String) {
        marketVM.result = result
        result = marketVM.deleted(id: id,cv: collectionView)
    }
    func removeAllBasket(id: [String]) {
        /*
        for i in 0...result.count {
            for uid in id {
                if result[i].id == uid {
                    result[i].addedCount! = 0
                    result[i].isBasket = nil
                    return
                }
                break
            }
            
        }
        collectionView.reloadData()
         */
    }
    func updateBasket(Index: Int)
    {
        marketVM.result = result
        result = marketVM.basketAddedProduct(index: Index)
    }
    func deleteBasket(Index2: Int) {
        marketVM.result = result
        result = marketVM.basketDeletedProduct(index: Index2)
    }
}

   

