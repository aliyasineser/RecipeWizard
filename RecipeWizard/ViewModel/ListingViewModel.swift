//
//  ListingViewModel.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 12.11.2021.
//

import Foundation


class ListingViewModel {
    
    
    var ingredients: [String] {
        didSet {
           self.bindIngredientToVMToVC()
        }
    }
    
    var bindIngredientToVMToVC : (() -> ()) = {}

    
    init() {
        self.ingredients = []
        self.bindIngredientToVMToVC()
    }
    
}
