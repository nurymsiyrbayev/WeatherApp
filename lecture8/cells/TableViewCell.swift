//
//  TableViewCell.swift
//  lecture8
//
//  Created by admin on 12.02.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = String(describing: TableViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var wetherMainLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ item: Daily?) {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = .systemTeal
        wetherMainLabel.text = item?.weather?.first?.main
        tempLabel.text = "\( Int(item?.temp?.day ?? 0.0))°"
        wetherMainLabel.textColor = .white
        wetherMainLabel.sizeToFit()
        wetherMainLabel.font = wetherMainLabel.font.withSize(24)
        tempLabel.sizeToFit()
        tempLabel.textColor = .white
        tempLabel.font = tempLabel.font.withSize(28)
        
    }
}
