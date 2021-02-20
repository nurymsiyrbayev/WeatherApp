//
//  CityListTableViewCell.swift
//  lecture8
//
//  Created by ADMIN ODoYal on 19.02.2021.
//

import UIKit

class CityListTableViewCell: UITableViewCell {
    static let identifier = String(describing: CityListTableViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ cityName: String?) {
        self.backgroundColor = .systemTeal
        cityNameLabel.text = cityName
        cityNameLabel.font = cityNameLabel.font.withSize(28)
        cityNameLabel.textColor = .white
        cityNameLabel.sizeToFit()
    }
    
}
