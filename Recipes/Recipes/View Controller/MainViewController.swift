//
//  MainViewController.swift
//  Recipes
//
//  Created by Matthew Martindale on 3/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    {
        didSet {
            recipesTableViewController?.recipes = self.allRecipes
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = allRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    func resetRecipes() {
        filteredRecipes = allRecipes
    }
    
    var searching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        networkClient.fetchRecipes { (recipe, error) in
            if error != nil {
                NSLog("There was an error fetching recipes")
                return
            }
            guard let recipe = recipe else { return }
            DispatchQueue.main.async {
                self.allRecipes = recipe
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            let destinationVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destinationVC
        }
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            resetRecipes()
        } else {
            filteredRecipes = allRecipes.filter { $0.name.contains(searchText) }
            searching = true
        }
        recipesTableViewController?.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        resetRecipes()
    }
}
