//
//  MealListViewController.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 13.11.2021.
//

import UIKit
import Kingfisher
import SwiftUI

class MealListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var mealListTableView: UITableView!
    
    var mealListViewModel: MealListViewModel!
    var ingredients: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Table View Delegation
        self.mealListTableView.dataSource = self
        self.mealListTableView.delegate = self
        
        callToViewModelForUIUpdate()
    }

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            if self.mealListViewModel.meals.isEmpty {
                let alert = UIAlertController(title: "No Recipes", message: "Such a shame, I couldn't find a recipe for you..", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { (_) in
                    self.dismiss(animated: true, completion: nil)
                     }))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func callToViewModelForUIUpdate(){
        mealListViewModel = MealListViewModel(ingredients: self.ingredients)

        self.mealListViewModel.bindMealListToVMToVC = {
            self.updateDataSource()
        }
    }

    func updateDataSource(){
        DispatchQueue.main.async {
            self.mealListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mealListViewModel.meals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MealListItemTableViewCell.identifier, for: indexPath) as! MealListItemTableViewCell
        
        cell.mealImage.kf.setImage(with: URL(string: mealListViewModel.meals[indexPath.row].strMealThumb))
        cell.mealName.text = mealListViewModel.meals[indexPath.row].strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenMeal = mealListViewModel.meals[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "RecipeView", bundle: nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: RecipeViewController.identifier) as! RecipeViewController
        
        resultViewController.theMeal = chosenMeal
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    
}
