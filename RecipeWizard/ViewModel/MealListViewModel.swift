//
//  MealListViewModel.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 13.11.2021.
//

import Foundation

class MealListViewModel {
    var networkManager: NetworkManager = .shared
    
    var ingredients: [String] {
        didSet {
           self.bindMealListToVMToVC()
        }
    }
    
    var meals: [Meal] {
        didSet {
           self.bindMealListToVMToVC()
        }
    }
    
    var bindMealListToVMToVC : (() -> ()) = {}
    
    init(ingredients: [String]) {
        self.meals = []
        self.ingredients = ingredients
        bindMealListToVMToVC()
        
        networkManager.fetchMeal(with: self.ingredients) { [weak self] meals in
            do {
                self?.meals = try meals.get().meals
                self?.bindMealListToVMToVC()
            } catch {
                // Avoidable, the array will be empty
            }
        }
    }
    
}
