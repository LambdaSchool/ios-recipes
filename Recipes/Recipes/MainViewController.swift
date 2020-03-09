//
//  MainViewController.swift
//  Recipes
//
//  Created by Wyatt Harrell on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes(completion: <#T##([Recipe]?, Error?) -> Void#>)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func editingDidEnd(_ sender: Any) {
    }
    
    

}
