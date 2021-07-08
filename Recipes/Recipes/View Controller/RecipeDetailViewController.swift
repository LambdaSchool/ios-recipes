//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Juan M Mariscal on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        if let recipe = recipe, isViewLoaded {
            
            recipeNameLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }

}
