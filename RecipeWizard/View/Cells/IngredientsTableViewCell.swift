//
//  IngredientsTableViewCell.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 12.11.2021.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!
    static let identifier = "IngredientTableViewCell"
    
    var ingredient : String? {
        didSet {
            ingredientLabel.text = ingredient
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
