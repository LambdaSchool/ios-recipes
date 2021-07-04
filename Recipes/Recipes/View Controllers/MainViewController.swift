//
//  MainViewController.swift
//  Recipes
//
//  Created by Jesse Ruiz on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let anError = error {
                NSLog("There was an error: \(anError)")
            } else {
                guard let recipe = recipes else { return }
                self.allRecipes = recipe
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func actionTextField(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayTableView" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.textField.text else { return }
            if text.isEmpty {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter({ $0.name == text || $0.instructions == text})
            }
        }
    }
    
    
    
    
}
