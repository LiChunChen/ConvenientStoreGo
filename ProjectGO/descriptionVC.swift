//
//  descriptionVC.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class descriptionVC: UIViewController {
    
    var information: [Item]?
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ingredientTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = information?[0].description
        ingredientTextView.text = information?[0].ingredient
        descriptionTextView.isEditable = false
        ingredientTextView.isEditable = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

