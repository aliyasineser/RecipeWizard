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
    
    private var dataSource : GenericTableViewDataSource<MealListItemTableViewCell,Meal>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mealListTableView.dataSource = self
        self.mealListTableView.delegate = self
        callToViewModelForUIUpdate()
    }

    func callToViewModelForUIUpdate(){
        mealListViewModel = MealListViewModel(ingredients: self.ingredients)
        
        let label = createEmptyLabel()
        label.isHidden = true
        self.view.addSubview(label)
        
        
        self.mealListViewModel.bindMealListToVMToVC = {
             
            label.isHidden = !self.mealListViewModel.meals.isEmpty
            
            self.updateDataSource()
        }
    }
    
    func createEmptyLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        label.center = CGPoint(x: view.center.x, y: view.center.y/2)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Such a shame, I couldn't find a recipe for you.."
        return label
    }
    
    func updateDataSource(){
        self.dataSource = GenericTableViewDataSource(cellIdentifier: MealListItemTableViewCell.identifier, items: self.mealListViewModel.meals, configureCell: { (cell, meal) in
            cell.mealImage.kf.setImage(with: URL(string: meal.strMealThumb))
            cell.mealName.text = meal.strMeal
            
        }, update: { [weak self]
            meals in
            self?.mealListViewModel.meals = meals
        })
        
        DispatchQueue.main.async {
            self.mealListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mealListViewModel.meals.count
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
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
        
        resultViewController.theMeal = chosenMeal
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    
}
