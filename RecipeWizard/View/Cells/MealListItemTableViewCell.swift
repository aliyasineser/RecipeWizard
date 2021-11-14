//
//  MealListItemTableViewCell.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 13.11.2021.
//

import UIKit

class MealListItemTableViewCell: UITableViewCell {
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    
    static let identifier = "MealListItemTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
