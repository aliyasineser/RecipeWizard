//
//  RecipeViewController.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 14.11.2021.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var mealRecipeLabel: UILabel!
    @IBOutlet weak var videoButton: UIButton!
    
    static let identifier = "RecipeViewController"
    
    var recipeViewModel: RecipeViewModel?
    var theMeal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ingredientsTableView.dataSource = self
        self.ingredientsTableView.delegate = self
        recipeViewModel = RecipeViewModel(meal: theMeal!)
        
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        self.recipeViewModel?.bindRecipeToVMToVC = { [weak self] in
            self?.isYoutubeButtonEnabled(self?.recipeViewModel?.recipe?.strYoutube == nil)
            self?.updateDataSource()
        }
    }
    
    func isYoutubeButtonEnabled(_ enabled: Bool) {
        self.videoButton.isEnabled = enabled
    }
    
    func updateDataSource(){
        DispatchQueue.main.async { [weak self] in
            self?.mealImage.kf.setImage(with: URL(string: self?.recipeViewModel?.recipe?.strMealThumb ?? ""))
            self?.mealRecipeLabel.text = self?.recipeViewModel?.recipe?.strInstructions
            self?.mealName.text = self?.recipeViewModel?.recipe?.strMeal
            self?.ingredientsTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeViewModel?.recipe?.ingredients.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailTableViewCell.identifier, for: indexPath) as! IngredientDetailTableViewCell
        
        let arrayValues = recipeViewModel?.recipe?.ingredients.values.map({$0})
        let arrayKeys = recipeViewModel?.recipe?.ingredients.keys.map({$0})

        cell.ingredientName.text = arrayKeys?[indexPath.row]
        cell.ingredientAmount.text = arrayValues?[indexPath.row]
        return cell
    }
    
    @IBAction func watchVideoButton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: recipeViewModel?.recipe?.strYoutube ?? "https://www.youtube.com")! as URL)
    }
    
}
