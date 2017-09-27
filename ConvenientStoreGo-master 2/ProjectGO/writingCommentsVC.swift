//
//  writingCommentsVC.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class writingCommentsVC: UIViewController {

    @IBOutlet weak var ratingStarView: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的評論"
        ratingStarView.text = String(ratingStarView.rating)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func doneButton(_ sender: Any) {
        //write in database
        self.dismiss(animated: true, completion: nil)
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
