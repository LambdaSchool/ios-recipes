//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jesse Ruiz on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
       
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let recipe = recipe,
            isViewLoaded else { return }
        recipeTitle.text = recipe.name
        recipeText.text = recipe.instructions
    }
    
    // MARK: - State Restoration
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        // Recipe -> Data -> Encode in coder
        
        defer { super.encodeRestorableState(with: coder) }
        
        var recipeData: Data?
        
        do {
            recipeData = try PropertyListEncoder().encode(recipe)
        } catch {
            NSLog("Error encoding recipe: \(error)")
        }
        
        guard let recipe = recipeData else { return }
        
        coder.encode(recipe, forKey: "recipeData")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        defer { super.decodeRestorableState(with: coder) }
        
        // Data -> Recipe -> Put in the Recipe var
        guard let recipeData = coder.decodeObject(forKey: "recipeData") as? Data else { return }
        
        self.recipe = try? PropertyListDecoder().decode(Recipe.self, from: recipeData)
    }
}
