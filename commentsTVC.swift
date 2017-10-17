//
//  commentsTVC.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class commentsTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var comment = userComment()

    @IBOutlet weak var showStarView: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showStarView.updateOnTouch = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    
    }
    
   
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //let star = tableView.dequeueReusableCell(withIdentifier: "star", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
        
        /*
         guard nameTF.text != "" else{
         comment.name = "Unknown"
         return
         }
         comment.name = nameTF.text
         comment.description = tf.text
         comment.starCount = ratingStarView.rating
         self.dismiss(animated: true, completion: nil) */
    
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
