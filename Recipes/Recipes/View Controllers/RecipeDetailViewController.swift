//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Mitchell Budge on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe? {
        didSet {
        updateViews()
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        if let newRecipe = recipe {
            recipeDetailLabel.text = newRecipe.name
            recipeDetailTextView.text = newRecipe.instructions
        }
    } // end of update views

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    } // end of view did load
    
    @IBOutlet weak var recipeDetailLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!

}
