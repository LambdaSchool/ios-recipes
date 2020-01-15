//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Joshua Rutkowski on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowRecipeSegue", let indexPath = tableView.indexPathForSelectedRow {
             guard let recipeDetailVC = segue.destination as? RecipeDetailViewController else { return }
                recipeDetailVC.recipe = recipes[indexPath.row]
                recipeDetailVC.recipes = recipes
        }
    }

}
