//
//  RecipeViewModel.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 14.11.2021.
//

import Foundation

class RecipeViewModel {
    var networkManager: NetworkManager = .shared
    
    var recipe: RecipeModel? {
        didSet {
           self.bindRecipeToVMToVC()
        }
    }
    
    var meal: Meal {
        didSet {
           self.bindRecipeToVMToVC()
        }
    }
    
    var bindRecipeToVMToVC : (() -> ()) = {}
    
    init(meal: Meal) {
        self.meal = meal
        bindRecipeToVMToVC()
        
        networkManager.fetchRecipe(with: meal.idMeal) { [weak self] recipes in
            do {
                let lookup = try recipes.get()
                if let foundRecipe = lookup.meals.first {
                    self?.recipe = RecipeModel(recipe: foundRecipe)
                }
                self?.bindRecipeToVMToVC()
            } catch {
                // Avoidable, the array will be empty
            }
        }
    }
    
}

