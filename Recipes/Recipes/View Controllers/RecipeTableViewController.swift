//
//  RecipeTableViewController.swift
//  Recipes
//
//  Created by Bree Jeune on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//


import UIKit

class RecipeTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    }


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! RecipeTableViewCell

        let rcp = recipes[indexPath.row]
        cell.textLabel?.text = rcp.name

        return cell
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CellToDetailViewSegue",
           let recipeDetailVC = segue.destination as? RecipeDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            recipeDetailVC.recipe = recipes[indexPath.row]
    }
    
    }

}
