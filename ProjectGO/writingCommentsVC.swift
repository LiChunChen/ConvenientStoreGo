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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的評論"
        
        //show star count number on screen
        ratingStarView.didFinishTouchingCosmos = {
            rating in
            self.ratingStarView.text = String(self.ratingStarView.rating)
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
            let alert = UIAlertController(title: "評論不可為空白", message: "請輸入您對此商品的評論", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        if nameTF.text == "" {
            name = "Unknown"
        }else {
            name = nameTF.text!
        }
        print(name)
        let dictionary = ["name":name,"comment":tf.text!,"barcode":barcodes![0]] as [String : Any]
        urlManager.changeToDB(parameter: dictionary, urlString: insertURL)
        
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
