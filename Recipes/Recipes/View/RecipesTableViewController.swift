//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var recipeController: RecipeController?

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipe = recipeController?.recipes[indexPath.row] else { return }
            
            recipeController?.delete(recipe)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeSegue" {
            let destinationVC = segue.destination as! RecipeDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = recipes[indexPath.row]
            
            destinationVC.recipe = recipe
            destinationVC.recipeController = recipeController
        }
    }

}
