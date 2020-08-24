//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Joseph Rogers on 10/29/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDetailsView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    
    func updateViews() {
        guard let recipe = recipe, self.isViewLoaded == true else {return}
        recipeNameLabel.text = recipe.name
        recipeDetailsView.text = recipe.instructions
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
