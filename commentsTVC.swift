//
//  commentsTVC.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class commentsTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var comments = [userComment]()
    override func viewDidLoad() {
        super.viewDidLoad()

        if comments.count == 0 {
            let alert = UIAlertController(title: "沒有評論", message: "目前沒有任何使用者對此商品進行評論", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "知道了", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return comments.count == 0 ? 0:comments.count
    }
    
   
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommentsTableViewCell
        
        let row = indexPath.row
        cell.usernameLabel.text = comments[row].name
        cell.commentsTextView.text = comments[row].comment
        cell.showStarView.rating = Double(comments[row].stars)
    
        return cell
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
