//
//  BasketViewController.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 17.09.2022.
//

import UIKit
import Kingfisher



class BasketViewController: UIViewController {
    
    private let BasketVM = BasketViewModel()
    
    var delegate : MarketViewControllerDelegate?
    
    var check : String?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var priceTotalLabel: UILabel!
    @IBOutlet var buyButton: UIButton!
    
    var id : String?
    var deg = 0.0
    var totalPrice: String?
    var result : [Data] = []
    var price : Double = 0.0 {
        didSet {
            deg += price
            priceTotalLabel.text = "\(deg)"
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getCheck()
        buyButton.isEnabled = true
        priceTotalLabel.text = totalPrice
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "delete.png"), style: .plain, target: self, action: #selector(removeBasket))
        buyButton.layer.cornerRadius = 15
        buyButton.layer.borderWidth = 5
        buyButton.layer.borderColor = UIColor.systemPink.cgColor
    }
    @objc func removeBasket() {
        let alert = UIAlertController(title: title, message: "Sepeti Sıfırlamak İstiyor Musunuz?", preferredStyle: UIAlertController.Style.alert)
        let okButton2 = UIAlertAction(title: "Temizle", style: UIAlertAction.Style.default) { UIAlertAction in
            self.priceTotalLabel.text = "Sepetiniz Boş!"
            self.buyButton.isEnabled = false
            self.delegate?.removeAllBasket(data: self.result)
            self.result.removeAll()
            self.tableView.reloadData()

        }
        let cancelButton = UIAlertAction(title: "İptal Et", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton2)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
   
    @IBAction func buyButton(_ sender: Any) {
        alert()
    }
    func getCheck(){
        let url = URL(string: "https://i.tmgrup.com.tr/mulakat/post-onay.json")
        WebService().getCheck(url: url!) { data in
            if let data = data {
                self.check = data.message
            }
        }
    }
    func alert() {
    
        let alert = UIAlertController(title: "Sepet Onayı" , message: "Sepeti Onaylıyor Musunuz?", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
            let alert2 = UIAlertController(title: "Succesfully", message: self.check, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                self.delegate?.removeAllBasket(data: self.result)
                self.result.removeAll()
                self.tableView.reloadData()
            }
            alert2.addAction(okButton)
            self.present(alert2, animated: true)
            
        }
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
         
    }
}
/*
extension UIAlertController{
    class func customAlertController(title : String, message : String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Tamam", style: .default) {
            (action: UIAlertAction) in
            let alertController2 = UIAlertController(title: "OK", message: "ONAY", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController2.addAction(okAction)
        }
        let deleteAct = UIAlertAction(title: "İptal", style: .destructive) {
            (action: UIAlertAction) in print("SKSSSs")
        }
        alertController.addAction(OKAction)
        alertController.addAction(deleteAct)
        return alertController
    }
}
 */

extension BasketViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BasketVM.filter(result: result).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let productVM = BasketVM.filter(result: result)[indexPath.row]
        cell.delegate = self
        cell.set(product: productVM, tag: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let productVM = BasketVM.filter(result: result)[indexPath.row]
            var filtered = result.filter{$0.isBasket == true}
            for resuls in result {
                if resuls.id == productVM.id {
                    self.result.remove(at: indexPath.row)
                    tableView.reloadData()
                    

                }
            }
          
        }
    }
    
    
}

extension BasketViewController : TableViewCellDelegate {
    func deleted(id: String, buttonTag: Int) {
        BasketVM.result = result
        result =  BasketVM.countIncrement(id: id)
        delegate?.update2(id: id)
        let productVM = BasketVM.filter(result: result)[buttonTag]
        let a = (productVM.price! * Double(productVM.addedCount!))
        priceTotalLabel.text = "\(a)"
        self.tableView.reloadData()
       
    }
    func added(id: String, buttonTag: Int) {
        BasketVM.result = result
        result = BasketVM.countAdded(id: id)
        delegate?.update(id: id)
        let productVM = BasketVM.filter(result: result)[buttonTag]
        let a = (productVM.price! * Double(productVM.addedCount!))
        priceTotalLabel.text = "\(a)"
        tableView.reloadData()
    }
    
}


   



    
