//
//  RecipeController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

class RecipeController {
    private(set) var recipes: [Recipe] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD Methods
    //Method to create a new recipe and add it to the array
    func createRecipe(name: String, instructions: String) {
        let recipe = Recipe(name: name, instructions: instructions)
        
        recipes.append(recipe)
        saveToPersistentStore()
    }
    //Method to update an existing recipe
    func update(_ recipe: Recipe, name: String, instructions: String) {
        guard let index = recipes.index(of: recipe) else { return }
        
        recipes[index].name = name
        recipes[index].instructions = instructions
        
        saveToPersistentStore()
    }
    
    //Method to delete an existing recipe
    func delete(_ recipe: Recipe) {
        guard let index = recipes.index(of: recipe) else { return }
        
        recipes.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    // Computed variable that returns the URL for the persistent store
    private var persistentStoreURL: URL? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let recipesFileName = "recipes.plist"
        
        return documentsURL.appendingPathComponent(recipesFileName)
    }
    
    // Method to encode recipes array and write it to disk
    private func saveToPersistentStore() {
        guard let url = persistentStoreURL else { return }
        
        let plistEncoder = PropertyListEncoder()
        
        do {
            let recipeData = try plistEncoder.encode(recipes)
            try recipeData.write(to: url)
        } catch {
            NSLog("Error saving recipes to persistent store: \(error)")
        }
    }
    
    // Method to read recipes data from disk and decode it
    private func loadFromPersistentStore() {
        guard let url = persistentStoreURL, FileManager.default.fileExists(atPath: url.path) else { return }
        
        let plistDecoder = PropertyListDecoder()
        
        do {
            let recipeData = try Data(contentsOf: url)
            recipes = try plistDecoder.decode([Recipe].self, from: recipeData)
        } catch {
            NSLog("Error loading recipes from persistent store: \(error)")
        }
    }
}
