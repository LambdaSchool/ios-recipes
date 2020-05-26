//
//  MainViewController.swift
//  Recipes
//
//  Created by Vijay Das on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    
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
    
    func filterRecipes() {
        
        DispatchQueue.main.async {
            
            guard let text = self.searchField.text,
                text != "" else {
                    self.filteredRecipes = self.allRecipes
                    return
            }
            
            let matchingRecipes = self.allRecipes.filter ({ $0.name.contains(String(text.lowercased())) ||
                $0.instructions.contains(String(text.lowercased())) })
            
            self.filteredRecipes = matchingRecipes
            
        }
        
        
        
    }
    
    @IBAction func searchCompleted(_ sender: UITextField) {

        filterRecipes()
        
        resignFirstResponder()
        
 
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            
            if let error = error {
                NSLog("Error: \(error)")
//                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
        }
        }

        // Do any additional setup after loading the view.
    }
    

 
    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tableViewSegue" {
            
 //         let recipiesTVC = segue.destination as! RecipesTableViewController
            
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
     }
        
 

}
