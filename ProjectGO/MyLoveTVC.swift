//
//  MyLoveTVC.swift
//  BarCode
//
//  Created by ChenLiChun on 2017/9/12.
//  Copyright © 2017年 ChenLiChun. All rights reserved.
//

import UIKit

class MyLoveTVC: UITableViewController {
    
    var urlManager = URLManager()
    var favorites = MyLove.sharedInstance()
    var informations = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My favorite"
        
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let allLove = UserDefaults.standard.object(forKey: "Favorites") {
            favorites.myLoveList = allLove as! [Int]
        }
        
        guard favorites.myLoveList.count != 0 else {
            let alert = UIAlertController(title: "0 record.", message: " You haven’t added anything to my favorite.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Create and add the view to the screen.
        let progressHUD = ProgressHUD(text: "Loading")
        self.view.addSubview(progressHUD)
        // All done!
        
        urlManager.askForRequest(parameters: favorites.myLoveList, urlString: requestURL) { (success, error, results) in
            guard success == true else {
                print("askForRequest fail.")
                return
            }
            guard let results = results else {
                print("Get results fail.")
                return
            }
            progressHUD.isHidden = true
            self.informations = results
            self.tableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.myLoveList.count == 0 {
            return 0
        }else {
            return favorites.myLoveList.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryRecordCell
        
        guard informations.isEmpty == false else {
            return cell
        }
        let row = indexPath.row
        let data = NSData(contentsOf: URL(string: informations[row].imgURL!)!)
        if data != nil {
            cell.itemImg.image = UIImage(data:data! as Data)
        }
        cell.itemName.text = informations[row].name
        cell.itemDetail.text = informations[row].ml
        if let heart = informations[row].favorite {
            cell.heartNum.text = String(describing: heart)
        }
        if let star = informations[row].stars {
            cell.starsNum.text = String(describing: star)
        }
        if informations[row].stars! == 5.0 {
            cell.itemStars.image = UIImage(named: "star5")
        }else if informations[row].stars! >= 4.0 {
            cell.itemStars.image = UIImage(named: "star4")
        }else if informations[row].stars! >= 3.0 {
            cell.itemStars.image = UIImage(named: "star3")
        }else if informations[row].stars! >= 2.0 {
            cell.itemStars.image = UIImage(named: "star2")
        }else {
            cell.itemStars.image = UIImage(named: "star1")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewcontroller.barcodes = [informations[indexPath.row].barcode!]
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.myLoveList.remove(at: indexPath.row)
            informations.remove(at: indexPath.row)
            UserDefaults.standard.set(favorites.myLoveList, forKey: "Favorites")
            UserDefaults.standard.synchronize()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

