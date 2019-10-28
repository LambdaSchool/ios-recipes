//
//  LocalRecipesStoreController.swift
//  Recipes
//
//  Created by Jon Bash on 2019-10-28.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class LocalRecipesStoreController {
    
    // MARK: - Properties
    
    var recipes: [Recipe] = []
    
    // MARK: - Singleton Instance
    
    private static var _shared: LocalRecipesStoreController?
    static var shared: LocalRecipesStoreController {
        if let instance = _shared {
            return instance
        } else {
            _shared = LocalRecipesStoreController()
            return _shared!
        }
    }
    
    func update(_ oldRecipe: Recipe, to newRecipe: Recipe) {
        guard let index = recipes.firstIndex(where: {
            $0.name == oldRecipe.name && $0.instructions == oldRecipe.instructions
        }) else { return }
        
        recipes[index] = newRecipe
        saveRecipesToLocalStore()
    }
    
    // MARK: - Persistence
    
    private var localRecipesURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Cannot get recipes URL; invalid directory?")
            return nil
        }
        return dir.appendingPathComponent("Recipes.plist")
    }
    
    /// Encodes and saves recipes list to plist.
    func saveRecipesToLocalStore() {
        guard let url = localRecipesURL else {
            print("Invalid url for recipes list.")
            return
        }
        do {
            let encoder = PropertyListEncoder()
            let recipesData = try encoder.encode(recipes)
            try recipesData.write(to: url)
        } catch {
            print("Error saving recipes list data: \(error)")
        }
    }
    
    /// Decodes and loads recipes list from plist.
    func didLoadRecipesFromLocalStore() -> Bool {
        let fm = FileManager.default
        guard let url = localRecipesURL else {
            print("Invalid url for recipes list.")
            return false
        }
        if !fm.fileExists(atPath: url.path) {
            print("Recipes list data file does not yet exist!")
            return false
        }
        do {
            let recipesData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            recipes = try decoder.decode([Recipe].self, from: recipesData)
        } catch {
            print("Error loading recipes list data: \(error)")
            return false
        }
        return true
    }
}
