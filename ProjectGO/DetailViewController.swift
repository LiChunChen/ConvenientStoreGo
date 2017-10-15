//
//  DetailViewController.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    var menuShowing = false

    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var myFavBut: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var showStarView: CosmosView!
    
    var descriptionVC: descriptionVC!
    
    var pressed = true
    
    lazy var commentsTVC: commentsTVC = {
        self.storyboard!.instantiateViewController(withIdentifier: "commentsTVC") as! commentsTVC
    }()
    
    var selectedVC:UIViewController!
    
    @IBOutlet weak var starCountsLabel: UILabel!
    
    @IBOutlet weak var favoriteCountsLabel: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectedVC = descriptionVC
        
        //prepare to present product title
        self.title = ""
        
        detailSegmentControl.addTarget(self, action: #selector(onControl(sender:)), for: .valueChanged)
        
        showStarView.updateOnTouch = false
        
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
        let likedImage = UIImage(named: "liked00")
        let likeImage = UIImage(named: "like00")
        if pressed == true{
            myFavBut.setImage(likedImage, for: .normal)
            pressed = false
        }else{
            myFavBut.setImage(likeImage, for: .normal)
            pressed = true
            
        }
        
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
        if (menuShowing) {
            leadingConstraint.constant = -140
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            leadingConstraint.constant = 0
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
