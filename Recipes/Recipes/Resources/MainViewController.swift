//
//  MainViewController.swift
//  Recipes
//
//  Created by Bree Jeune on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] { didSet { filterRecipes() } }
    var recipesTableViewController: RecipeTableViewController? { didSet { recipesTableViewController?.recipes = filteredRecipes } }
    private var filteredRecipes: [Recipe] = [] { didSet { recipesTableViewController?.recipes = filteredRecipes } }

    @IBOutlet weak var recipeTextField: UITextField!
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        filterRecipes()
    }

    private func fetchRecipes() {
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("There was an error fetching recipes: \(error)")
                return
            }

            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        }
    }

    private func filterRecipes() {
        guard let searchText = recipeTextField.text,
              !searchText.isEmpty else {
            filteredRecipes = allRecipes
            return
        }

        filteredRecipes = allRecipes.filter {
            $0.name.localizedStandardContains(searchText) || $0.instructions.localizedStandardContains(searchText)
        }
    }

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipes()
    }


    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbeddedTableViewSegue" {
            recipesTableViewController = segue.destination as? RecipeTableViewController
        }
    }

}


