//
//  DetailRecipeViewController.swift
//  Recipes
//
//  Created by Matthew Martindale on 3/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class DetailRecipeViewController: UIViewController {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeInstructionsTextField: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            if let name = recipe?.name,
                let instructions = recipe?.instructions {
                recipeNameLabel.text = name
                recipeInstructionsTextField.text = instructions
            }
        }
    }

}
