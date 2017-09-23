//
//  WalkthroughContentViewController.swift
//  GoGoGo
//
//  Created by gnoocl on 2017/9/9.
//  Copyright © 2017年 gnoocl. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet weak var contentTextLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var forwardBtn: UIButton!
    var index=0
    var heading = ""
    var content = ""
    var imageFile = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headingLabel.text = heading
        contentTextLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        switch index{
        case 0,1,2 : forwardBtn.isHidden = true
        case 3 : forwardBtn.setTitle("開始使用APP", for: .normal)
        default:break
            

        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func nextBtn(_ sender: Any) {
////        self.view.window?.rootViewController = BarCodeViewController()
//        
//    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//}

