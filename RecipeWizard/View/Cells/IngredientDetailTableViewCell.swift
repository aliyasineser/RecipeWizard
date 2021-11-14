//
//  IngredientDetailTableViewCell.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 14.11.2021.
//

import UIKit

class IngredientDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientAmount: UILabel!
    
    
    static let identifier = "IngredientDetailTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
