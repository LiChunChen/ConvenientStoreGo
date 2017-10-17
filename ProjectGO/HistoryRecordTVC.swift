//
//  HistoryRecordTVC.swift
//  BarCode
//
//  Created by ChenLiChun on 2017/9/11.
//  Copyright © 2017年 ChenLiChun. All rights reserved.
//

import UIKit

class HistoryRecordTVC: UITableViewController {
    
    var urlManager = URLManager()
    var historys = History.sharedInstance()
    var informations = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let alert = UIAlertController(title: "0筆記錄", message: "您目前還沒有瀏覽過任何商品", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "知道了", style: .default, handler: nil))
        
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableViewAutomaticDimension
        guard historys.historyList.count != 0 else {
            present(alert, animated: true, completion: nil)
            return
        }
        
        urlManager.askForRequest(parameters: historys.historyList, urlString: requestURL) { (success, error, results) in
            guard success == true else {
                print("askForRequest fail.")
                return
            }
            guard let results = results else {
                print("Get results fail.")
                return
            }
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if historys.historyList.count == 0 {
            return 0
        }else {
            return historys.historyList.count
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
        cell.itemHeart.image = UIImage(named: "liked00")
        if let heart = informations[row].favorite {
            cell.heartNum.text = String(describing: heart)
        }
        cell.itemStars.image = UIImage(named: "")
        if let star = informations[row].stars {
            cell.starsNum.text = String(describing: star)
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
