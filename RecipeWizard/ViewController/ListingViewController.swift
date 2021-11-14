//
//  ViewController.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 12.11.2021.
//

import UIKit

class ListingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Labels are connected in case of localization
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var listingRequestLabel: UILabel!
    
    // Text field for taking ingredients
    @IBOutlet weak var ingredientTextField: UITextField!
    
    // Buttons for adding recipe and searching for recipes(segue)
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var findRecipeButton: UIButton!
    
    // Table View for the delegation
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    var listingViewModel = ListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View Delegation
        self.ingredientsTableView.dataSource = self
        self.ingredientsTableView.delegate = self
        
        self.listingViewModel = ListingViewModel()
        
        callToViewModelForUIUpdate()
    }
    
    // UI Setup function
    func callToViewModelForUIUpdate(){
        
        findRecipeButton.tintColor = .systemOrange
        addIngredientButton.tintColor = .systemOrange
        
        self.listingViewModel.bindIngredientToVMToVC = {
            self.updateDataSource()
        }
    }

    func updateDataSource(){
        DispatchQueue.main.async {
            self.ingredientsTableView.reloadData()
        }
    }
    
    // Add Button for the ingredient, checks if it's added before and also removes the text field
    @IBAction func addIngredient(_ sender: Any) {
        let ingredient = ingredientTextField.text
        
        if let ing = ingredient, !ing.isEmpty, !listingViewModel.ingredients.contains(ing) {
            listingViewModel.ingredients.append(ing)
            ingredientTextField.text = ""
        }
    }
    
    // Navigation for meal list screen. Passing the preprocessed ingredients.
    @IBAction func searchRecipes(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "MealList", bundle: nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MealListViewController") as! MealListViewController
        var parameterizedIngredients: [String] = [] // Ingredients will be preprocessed for the network call
        listingViewModel.ingredients.map({
            parameterizedIngredients.append( $0.lowercased().trimmingCharacters(in: CharacterSet.whitespaces).replacingOccurrences(of:" ", with: "_"))
            })
        resultViewController.ingredients = parameterizedIngredients
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listingViewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listingViewModel.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as! IngredientsTableViewCell
        cell.ingredient = listingViewModel.ingredients[indexPath.row]
        return cell
    }
    
}

