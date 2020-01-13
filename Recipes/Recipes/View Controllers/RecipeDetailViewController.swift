//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Michael on 1/13/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
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
    
    func updateViews() {
        guard let name = recipe?.name, let instructions = recipe?.instructions, isViewLoaded else { return }
        
        recipeNameLabel.text = name
        recipeTextView.text = instructions
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
