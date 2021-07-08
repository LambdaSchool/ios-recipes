//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Matthew Martindale on 3/10/20.
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mainVC = MainViewController()
        if mainVC.searching {
            return mainVC.filteredRecipes.count
        } else {
            return recipes.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        //checks if user is searching in searchBar
        let mainVC = MainViewController()
        if mainVC.searching {
            cell.textLabel?.text = mainVC.filteredRecipes[indexPath.row].name
        } else {
            let recipe = recipes[indexPath.row]
            cell.textLabel?.text = recipe.name
        }
        
        cell.backgroundColor = .darkColor
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "DetailSegue" {
            let detailVC = segue.destination as! DetailRecipeViewController
            detailVC.recipe = recipes[indexPath.row]
        }
    }
    

}
