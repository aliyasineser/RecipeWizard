//
//  IngredientTableViewDataSource.swift
//  RecipeWizard
//
//  Created by ali.yasin.eser on 13.11.2021.
//

import Foundation
import UIKit

class GenericTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var update: (([T]) -> ()) = {_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> (), update: @escaping (([T]) -> ())) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.update = update
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            //1. remove data from model
            items.remove(at: indexPath.row)

            //2. remove row from view
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            update(items)
            
            //3. custom method to update your view after removing
            tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
}
