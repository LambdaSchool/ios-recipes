//
//  MainViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, UISearchResultsUpdating {

    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    let recipeController = RecipeController()
    var searchController: UISearchController!

    var filteredRecipes: [Recipe] = [] {
        didSet {
            updateRecipeTV()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            updateRecipeTV()
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Recipes"
        
        navigationItem.searchController = searchController
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        // Set an observer to see if the tableView updates the model controller
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.filterRecipes), name: NSNotification.Name("updateTableView"), object: nil)
        
        // Check if the user has previously loaded the recipes over the network
        let hasPreviouslyLoadedRecipes = UserDefaults.standard.bool(forKey: "HasLoadedRecipesFromNetwork")
        
        // If not, load them
        if !hasPreviouslyLoadedRecipes {
            networkClient.fetchRecipes { (recipes, error) in
                if let error = error {
                    NSLog("Error fetching recipes: \(error)")
                }
                
                guard let recipes = recipes else { return }
                for recipe in recipes {
                    self.recipeController.createRecipe(name: recipe.name, instructions: recipe.instructions)
                }
                
                UserDefaults.standard.set(true, forKey: "HasLoadedRecipesFromNetwork")
                print("I loaded these recipes from the network!")
                self.filterRecipes(nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filterRecipes(nil)
    }
    
    // MARK: - UI Search Results Updating
    func updateSearchResults(for searchController: UISearchController) {
        filterRecipes(searchController.searchBar.text)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipeTableView" {
            let destinationVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destinationVC
        } else if segue.identifier == "AddRecipeSegue" {
            let destinationVC = segue.destination as! RecipeDetailViewController
            
            destinationVC.recipeController = recipeController
        }
    }
    
    // MARK: - Private Utility Methods
    @objc private func filterRecipes(_ searchText: String?) {
        DispatchQueue.main.async {
            // Make sure there is a search term, otherwise set the filtered recipes to all the recipes
            guard let searchTerm = searchText, !searchTerm.isEmpty else {
                self.filteredRecipes = self.recipeController.recipes
                return
            }
            
            // Get the recipes who's names match
            let namesMatch = self.recipeController.recipes.filter { $0.name.range(of: searchTerm, options: .caseInsensitive) != nil }
            // Get the recipes who's instructions match and aren't in the first group
            let instructionsMatch = self.recipeController.recipes.filter { $0.instructions.range(of: searchTerm, options: .caseInsensitive) != nil && namesMatch.index(of: $0) == nil }
            
            // Add them together and put them in the filtered array
            self.filteredRecipes = namesMatch + instructionsMatch
        }
    }
    
    private func updateRecipeTV() {
        recipesTableViewController?.recipes = filteredRecipes
        recipesTableViewController?.recipeController = recipeController
    }

}
