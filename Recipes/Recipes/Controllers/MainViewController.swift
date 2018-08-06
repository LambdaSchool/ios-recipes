//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda-School-Loaner-11 on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    private var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textFieldEndEditing(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if self.textField.text == nil {
                self.filteredRecipes = self.allRecipes
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error \(error)")
            }
            self.allRecipes = allRecipes ?? []
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSegue" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
}
