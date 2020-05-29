//
//  MainViewController.swift
//  Recipes
//
//  Created by Kat Milton on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    
    var recipesTableViewController: RecipeTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.clearButtonMode = .always
        
        networkClient.fetchRecipes { allRecipes, error in
            if let error = error {
                let errorText: () = NSLog("Error loading recipes: \(error)")
                return errorText
            }
            
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
            
        }
    }
    
    // MARK: - Functions
    
    func filterRecipes() {
        if let searchTerm = searchTextField.text {
            if searchTerm != "" {
                filteredRecipes = allRecipes.filter {
                $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
            } else if searchTerm == "" {
                filteredRecipes = allRecipes
                }
            else {
                filteredRecipes = allRecipes
            }

            }
        
        }
    
    
    
    
    
    // MARK: - IBActions
    
    @IBAction func searchForRecipe(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
        
    }

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeListSegue" {
            recipesTableViewController = (segue.destination as! RecipeTableViewController)
        }
    }
    

}
