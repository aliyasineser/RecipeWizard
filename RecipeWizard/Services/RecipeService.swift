//
//  RecipeService.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 12.11.2021.
//

import Foundation
import Alamofire
import RxSwift

struct URLRequestException: Error {
    
}

class NetworkManager{
    
    static let shared = NetworkManager()
    
    func fetchMeal(with ingredients: [String] , completion: @escaping (Result<FilteredMeals, Error>) -> () ) {
        let urlString = RecipeRequest.filterByMultiIngredient(ingredients)
        fetchData(urlString: urlString.url, completion: completion)
    }
    
    func fetchRecipe(with idMeal: String , completion: @escaping (Result<Lookup, Error>) -> () ) {
        let urlString = RecipeRequest.lookup(idMeal)
        fetchData(urlString: urlString.url, completion: completion)
    }

    fileprivate func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> () ) {
    
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let data = data else { return }
            do {
                let decoded: T = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}



struct RecipeServer {
    // API Key should be stored securely. However, I put it for the time concerns.
    static let apiKey = "9973533"
    static let baseUrl = "https://www.themealdb.com/api/json/v2"
    
}

enum RecipeRequest {
 
    case filterByMultiIngredient([String])
    case lookup(String)

    var url: String {
        switch self {
        case .filterByMultiIngredient(let ingredients):
            return [RecipeServer.baseUrl, RecipeServer.apiKey, "filter.php?i="].joined(separator: "/") + ingredients.joined(separator: ",")
        case .lookup(let idMeal):
            return [RecipeServer.baseUrl, RecipeServer.apiKey, "lookup.php?i="].joined(separator: "/") + idMeal
        }
    }
    
}
