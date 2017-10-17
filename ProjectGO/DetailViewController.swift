//
//  DetailViewController.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var subMenu: UIView!
    
    @IBOutlet weak var itemName: UILabel!
    
    var barcodes: [Int]?
    let urlManager = URLManager()
    var information = [Item]()
    var isfavorite = false
    var favorites = MyLove.sharedInstance()
    var history = History.sharedInstance()
    var number = 0
    
 
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var menuShowing = false

    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var myFavBut: UIButton!
    @IBOutlet weak var writeComBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    var descriptionVC: descriptionVC!
    
//    var pressed = true
    
    lazy var commentsTVC: commentsTVC = {
        self.storyboard!.instantiateViewController(withIdentifier: "commentsTVC") as! commentsTVC
    }()
    
    var selectedVC:UIViewController!
    
    @IBOutlet weak var starCountsLabel: UILabel!
    
    @IBOutlet weak var favoriteCountsLabel: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem=nil
        self.navigationItem.hidesBackButton=true
        
        // Do any additional setup after loading the view.
        selectedVC = descriptionVC
        
        //prepare to present product title
        self.title = "商品"
        myFavBut.isEnabled = false
        writeComBtn.isEnabled = false
        history.historyList.append(barcodes![0])
        
        mainView.bringSubview(toFront: subMenu)
        
        detailSegmentControl.addTarget(self, action: #selector(onControl(sender:)), for: .valueChanged)
        
//        guard let barcodes = barcodes else {
//            return
//        }
        urlManager.askForRequest(parameters: barcodes!, urlString: requestURL) { (success, error, results) in
            guard success == true else {
                print("askForRequest fail.")
                return
            }
            guard let results = results else {
                print("Get results fail.")
                return
            }
            let data = NSData(contentsOf: URL(string: results[0].imgURL!)!)
            if data != nil {
                self.detailImage.image = UIImage(data:data! as Data)
            }
            self.itemName.text = results[0].name!
            self.information = results
            self.descriptionVC.information = results
            if self.favorites.myLoveList.count != 0 {
                for i in 0..<self.favorites.myLoveList.count {
                    if self.favorites.myLoveList[i] == self.barcodes![0] {
                        self.number = i
                        self.isfavorite = true
                        self.myFavBut.setImage(UIImage(named:"Cancel"), for: UIControlState.normal)
                    }
                }
            }
            self.myFavBut.isEnabled = true
            self.writeComBtn.isEnabled = true
            self.descriptionVC.self.viewDidLoad()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changePage(to newViewController:UIViewController){
        //remove controller from view
        selectedVC.willMove(toParentViewController: nil)
        selectedVC.view.removeFromSuperview()
        selectedVC.removeFromParentViewController()
        
        //add new viewController
        addChildViewController(newViewController)
        self.containerView.addSubview(newViewController.view)
        newViewController.view.frame = containerView.bounds
        newViewController.didMove(toParentViewController: self)
        
        //present
        self.selectedVC = newViewController
    }
    //connect to the descriptionVC, or it will be nil.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerViewSegue" {
            descriptionVC = segue.destination as! descriptionVC
        }
    }
  
    
    @objc func onControl(sender:UISegmentedControl) {
        
       if detailSegmentControl.selectedSegmentIndex == 0{
        changePage(to: descriptionVC)
        }
        else{
        changePage(to: commentsTVC)
        }
    }
    
    @IBAction func addToMyFav(_ sender: Any) {
        
        guard information[0].favorite != nil else {
            return
        }
        
        if isfavorite == false {
            information[0].favorite! += 1
            isfavorite = true
            myFavBut.setImage(UIImage(named:"Cancel"), for: UIControlState.normal)
            favorites.myLoveList.append(barcodes![0])
            print(favorites.myLoveList)
        }else {
            information[0].favorite! -= 1
            isfavorite = false
            myFavBut.setImage(UIImage(named:"Enter"), for: UIControlState.normal)
            favorites.myLoveList.remove(at: number)
        }
        
        let parameter = ["favorite":information[0].favorite!,"barcode":barcodes![0]] as [String : Any]
        urlManager.changeToDB(parameter: parameter, urlString: uploadURL)
        
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
        if (menuShowing) {
            trailingConstraint.constant = -140
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            trailingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
       
    }
    
    @IBAction func showScan(_ sender: Any) {
        let push1 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let barcodeVC = push1.instantiateViewController(withIdentifier: "BarCodeViewController")
        self.navigationController?.pushViewController(barcodeVC, animated: true)
        
    }
    @IBAction func showMap(_ sender: Any) {
        let push = UIStoryboard.init(name: "Map", bundle: nil)
        let mapVC = push.instantiateViewController(withIdentifier: "MapViewController")
        self.navigationController?.pushViewController(mapVC, animated: true)
        
    }
    
    @IBAction func showFav(_ sender: Any) {
        let push2 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let loveVC = push2.instantiateViewController(withIdentifier: "MyLoveTVC")
        self.navigationController?.pushViewController(loveVC, animated: true)
        
    }
    
    @IBAction func showRecord(_ sender: Any) {
        let modal2 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let recordVC = modal2.instantiateViewController(withIdentifier: "HistoryRecordTVC")
       self.navigationController?.pushViewController(recordVC, animated: true)
    }
    @IBAction func openDrink(_ sender: Any) {
        let modal3 = UIStoryboard.init(name: "IntroductionStoryboard", bundle: nil)
        let drinkVC = modal3.instantiateViewController(withIdentifier: "ItemsViewController")
        self.navigationController?.pushViewController(drinkVC, animated: true)
        
    }
    
    @IBAction func writingComment(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "writingCommentsVC") as? writingCommentsVC
        controller?.barcodes = barcodes!
        self.navigationController?.pushViewController(controller!, animated: true)
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
