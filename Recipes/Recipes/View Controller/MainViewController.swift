//
//  MainViewController.swift
//  Recipes
//
//  Created by Juan M Mariscal on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: Private Properties
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet { filterRecipes() }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet { recipesTableViewController?.recipes = self.filteredRecipes }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet { self.recipesTableViewController?.recipes = filteredRecipes }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                print("There is an error while fetching the recipes")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
            print(self.allRecipes)
        }
    }
    
    func filterRecipes() {
        if let recipeSearch = searchTextField.text , !recipeSearch.isEmpty {
            filteredRecipes = allRecipes.filter {$0.name.contains(recipeSearch)}
        } else {
            filteredRecipes = allRecipes
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    

    // MARK: IBActions
    
    @IBAction func textFieldEdited(_ sender: Any) {
        searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
}
