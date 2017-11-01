//
//  writingCommentsVC.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class writingCommentsVC: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var ratingStarView: CosmosView!
    
    let urlManager = URLManager()
    var barcodes: [Int]?
    var stars = 0.0
    var totalStars = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的評論"
//        print(totalStars)
        
        //show star count number on screen
        ratingStarView.didFinishTouchingCosmos = {
            rating in
            self.ratingStarView.text = String(self.ratingStarView.rating)
            self.stars = self.ratingStarView.rating
        }
        
        tf.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tf.resignFirstResponder()
        return true
    }
    
    @IBAction func doneButton(_ sender: Any) {
        //write in database
        var name = ""
        guard tf.text != "" else {
            let alert = UIAlertController(title: "Comments should not be blank", message: "Please enter your comments for the product.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        if nameTF.text == "" {
            name = "Unknown"
        }else {
            name = nameTF.text!
        }
//        print(name)
        let dictionary = ["name":name,"comment":tf.text!,"barcode":barcodes![0],"stars":stars] as [String : Any]
        urlManager.changeToDB(parameter: dictionary, urlString: insertURL)
        
        if totalStars == 0.0 {
            totalStars = stars
        }else {
            totalStars = (totalStars + stars)/2
        }
        
        let parameter = ["update":totalStars,"barcode":barcodes![0],"category":"stars"] as [String : Any]
        urlManager.changeToDB(parameter: parameter, urlString: uploadURL)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Update"), object: nil)
        
        self.navigationController?.popViewController(animated: true)
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
