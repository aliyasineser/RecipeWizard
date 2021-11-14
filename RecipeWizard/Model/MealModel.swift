//
//  MealModel.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 13.11.2021.
//

import Foundation

// MARK: - FilteredMeals
struct FilteredMeals: Codable {
    let meals: [Meal]
}

// MARK: - Recipe
struct Recipe: Codable {
    let strMeal: String?
    let idMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
}

struct RecipeModel {
    let strMeal: String!
    let idMeal: String!
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    var ingredients: [String: String]
    
    
    internal init(recipe: Recipe) {
        self.strMeal = recipe.strMeal
        self.idMeal = recipe.idMeal
        self.strDrinkAlternate = recipe.strDrinkAlternate
        self.strCategory = recipe.strCategory
        self.strArea = recipe.strArea
        self.strInstructions = recipe.strInstructions
        self.strMealThumb = recipe.strMealThumb
        self.strTags = recipe.strTags
        self.strYoutube = recipe.strYoutube
        self.strImageSource = recipe.strImageSource
        self.strCreativeCommonsConfirmed = recipe.strCreativeCommonsConfirmed
        self.dateModified = recipe.dateModified
        self.ingredients = [:]
        
        // Messy code, can be written in a loop if Recipe struct is bypassed and look from the lookup. Timewise, skipped
        // Also empty string could be checked better.
        if let ing = recipe.strIngredient1, let mes = recipe.strMeasure1, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient2, let mes = recipe.strMeasure2, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient3, let mes = recipe.strMeasure3, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient4, let mes = recipe.strMeasure4, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient5, let mes = recipe.strMeasure5, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient6, let mes = recipe.strMeasure6, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient7, let mes = recipe.strMeasure7, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient8, let mes = recipe.strMeasure8, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient9, let mes = recipe.strMeasure9, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient10, let mes = recipe.strMeasure10, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient11, let mes = recipe.strMeasure11, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient12, let mes = recipe.strMeasure12, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient13, let mes = recipe.strMeasure13, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient14, let mes = recipe.strMeasure14, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient15, let mes = recipe.strMeasure15, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient16, let mes = recipe.strMeasure16, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient17, let mes = recipe.strMeasure17, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient18, let mes = recipe.strMeasure18, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient19, let mes = recipe.strMeasure19, ing != "" {
            self.ingredients[ing] = mes
        }
        if let ing = recipe.strIngredient20, let mes = recipe.strMeasure20, ing != "" {
            self.ingredients[ing] = mes
        }
        
        
    }
    
}


// MARK: - Meal
struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

// Meal Details, such as recipe
struct Lookup: Codable {
    let meals: [Recipe]
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
