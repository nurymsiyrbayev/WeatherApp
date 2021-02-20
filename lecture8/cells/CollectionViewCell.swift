//
//  CollectionViewCell.swift
//  lecture8
//
//  Created by admin on 12.02.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ item : Current?){
        self.backgroundColor = .systemTeal
        temp.text = "\(Int(item?.temp ?? 0.0))°"
        feelsLike.text = "\(Int(item?.feels_like ?? 0.0))°"
        desc.text = item?.weather?.first?.description
        desc.textColor = .black
        desc.font = desc.font.withSize(14)
        temp.font = temp.font.withSize(22)
        feelsLike.font = feelsLike.font.withSize(20)
    }
}
