//
//  DetailViewController.swift
//  ProjectGO
//
//  Created by Michelle Chen on 2017/9/10.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    var descriptionVC: descriptionVC!
    
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
        
        self.title = ""
        
        detailSegmentControl.addTarget(self, action: #selector(onControl(sender:)), for: .valueChanged)
        
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
    
    @IBAction func myFavorButton(_ sender: Any) {
        //change heart image
        //add to my favorite
        
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
