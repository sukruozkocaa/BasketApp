//
//  CollectionViewCell.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 16.09.2022.
//

import UIKit
import Kingfisher


class CollectionViewCell: UICollectionViewCell {
        
    var delegate : MarketViewControllerDelegate?
    
    var stock : Int?
    var count : Int? = 0 {
        didSet {
            basketLabel.text = "\(count!)"
        }
    }
    var getCount : Int?
    
    @IBOutlet var decreaseButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var myView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var labelView: UIView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var basketLabel: UILabel!
    @IBOutlet var myView2: UIView!
    @IBOutlet var priceView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        addButton.layer.cornerRadius = 5
        decreaseButton.layer.cornerRadius = 5
        myView.layer.cornerRadius = 3
        myView2.layer.cornerRadius = 3
        myView2.layer.borderWidth = 1
        myView2.layer.borderColor = UIColor.systemGray3.cgColor
        addButton.isEnabled = true
        decreaseButton.isEnabled = false
        imageView.layer.cornerRadius = 3
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.black.cgColor
        decreaseButton.isEnabled = false
        myView.layer.backgroundColor = UIColor.systemGray4.cgColor
        labelView.layer.cornerRadius = 3
        labelView.layer.borderWidth = 0.1
        labelView.layer.borderColor = UIColor.black.cgColor
        priceLabel.layer.cornerRadius = 3
        priceView.layer.cornerRadius = 3
        priceView.layer.borderWidth = 0.7
        priceView.layer.borderColor = UIColor.black.cgColor
    }
    
    func set(product : Data, tag : Int){
        addButton.tag = tag
        decreaseButton.tag = tag
        priceLabel.text = "\(product.price!)" + " " + "\(product.currency!)"
        imageView.kf.setImage(with: URL(string:product.imageUrl!))
        nameLabel.text = product.name
        stock = product.stock
        getCount = product.addedCount
        if getCount == nil {
            getCount = 0
        }
        basketLabel.text = "\(getCount!)"
        count = getCount
        if count ==  0{
            addButton.isEnabled = true
            decreaseButton.isEnabled = false
        }
        if count! > 0 {
            decreaseButton.isEnabled = true
        }
         if stock == count! {
            addButton.isEnabled = false
            decreaseButton.isEnabled = true
        }
    }
    //MARK: Funcs Button
    @IBAction func addButton(_ sender: UIButton) {
        if (stock! > count!){
            decreaseButton.isEnabled = true
            count! += 1
        }
         if (count == stock!){
            addButton.isEnabled = false
            decreaseButton.isEnabled = true
        }
        delegate?.updateBasket(Index: sender.tag)
    }
    @IBAction func decreaseButton(_ sender: UIButton) {
        addButton.isEnabled = true
        if count == 1 {
            addButton.isEnabled = true
            decreaseButton.isEnabled = false
            count! -= 1
        }
        else {
            count! -= 1
        }
        delegate?.deleteBasket(Index2: sender.tag)
    }
}
