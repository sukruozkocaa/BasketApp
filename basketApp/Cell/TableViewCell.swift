//
//  TableViewCell.swift
//  basketApp
//
//  Created by Şükrü Özkoca on 18.09.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    var delegate : TableViewCellDelegate?
    

    @IBOutlet var labelCurrency: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pictureView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var totalBasketLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var id : String?
    var stock: Int?
    
    func set(product : Data,tag : Int) {
        addButton.tag = tag
        deleteButton.tag = tag
        
        nameLabel.text = product.name
        pictureView.kf.setImage(with: URL(string: product.imageUrl ?? ""))
        priceLabel.text = "\(product.price!)"
        labelCurrency.text = product.currency
        totalBasketLabel.text = "\(product.addedCount!)"
        
        //MARK: Variable Assign
        id = product.id
        stock = product.stock
        
        //MARK: Button Configure
        deleteButton.isEnabled = true
        addButton.isEnabled = true
        if product.addedCount == product.stock{
            addButton.isEnabled = false
        }
        if product.addedCount == 0 {
            deleteButton.isEnabled = false
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func addButton(_ sender: UIButton) {
        delegate?.added(id:id!, buttonTag: sender.tag)
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.deleted(id: id!, buttonTag: sender.tag)
    }
}

