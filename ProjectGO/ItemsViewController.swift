//
//  ViewController.swift
//  Project1
//
//  Created by gnoocl on 2017/9/12.
//  Copyright © 2017年 gnoocl. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController{

   
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    var menuShowing = false
    @IBOutlet weak var Page1Btn: UIButton!
    @IBOutlet weak var Page2Btn: UIButton!
    @IBOutlet weak var Page3Btn: UIButton!
    @IBOutlet weak var Page4Btn: UIButton!    
    @IBOutlet weak var Page5Btn: UIButton!
    @IBOutlet weak var Page6Btn: UIButton!
    @IBOutlet weak var Page7Btn: UIButton!
    @IBOutlet weak var Page8Btn: UIButton!
    @IBOutlet weak var Page9Btn: UIButton!
    @IBOutlet weak var containerView: UIView!
    var selectedButton: UIButton!
    // 1.
    var Page1TableViewController: Page1TableViewController!
    
    // 2.
    lazy var Page2TableViewController: Page2TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page2" )as! Page2TableViewController
    }()
    lazy var Page3TableViewController: Page3TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page3" )as! Page3TableViewController
    }()
    lazy var Page4TableViewController: Page4TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page4" )as! Page4TableViewController
    }()
    lazy var Page5TableViewController: Page5TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page5" )as! Page5TableViewController
    }()
    lazy var Page6TableViewController: Page6TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page6" )as! Page6TableViewController
    }()
    lazy var Page7TableViewController: Page7TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page7" )as! Page7TableViewController
    }()
    lazy var Page8TableViewController: Page8TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page8" )as! Page8TableViewController
    }()
    lazy var Page9TableViewController: Page9TableViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page9" )as! Page9TableViewController
    }()
    
    // 3.
    var selectedViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectedButton = Page1Btn
        selectedViewController = Page1TableViewController
        
        self.navigationItem.leftBarButtonItem=nil
        self.navigationItem.hidesBackButton=true
        
        
    }

    func changeTab(to newButton: UIButton) {
        // 先利用 tintColor 取得 Button 預設的文字顏色
        let defaultColor = selectedButton.tintColor
        // 將目前選取的按鈕改成未選取的顏色
        selectedButton.backgroundColor = UIColor.white
        selectedButton.setTitleColor(defaultColor, for: .normal)
        // 將參數傳來的新按鈕改成選取的顏色
        newButton.backgroundColor = UIColor.lightGray
        newButton.setTitleColor(UIColor.black, for: .normal)
        // 將目前選取的按鈕改為新的按鈕
        selectedButton = newButton
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerViewSegue" {
            Page1TableViewController = segue.destination as! Page1TableViewController
        }
    }
    func changePage(to newViewController: UIViewController) {
        // 2. Remove previous viewController
        selectedViewController.willMove(toParentViewController: nil)
        selectedViewController.view.removeFromSuperview()
        selectedViewController.removeFromParentViewController()
        
        // 3. Add new viewController
        addChildViewController(newViewController)
        self.containerView.addSubview(newViewController.view)
        newViewController.view.frame = containerView.bounds
        newViewController.didMove(toParentViewController: self)
        
        // 4.
        self.selectedViewController = newViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showPage1(_ sender: Any) {
        changeTab(to: Page1Btn)
        changePage(to: Page1TableViewController)
    }
    @IBAction func showPage2(_ sender: Any) {
        changeTab(to: Page2Btn)
        changePage(to: Page2TableViewController)
    }
    @IBAction func showPage3(_ sender: Any) {
        changeTab(to: Page3Btn)
        changePage(to: Page3TableViewController)
    }
    @IBAction func showPage4(_ sender: Any) {
        changeTab(to: Page4Btn)
        changePage(to: Page4TableViewController)
    }
    @IBAction func showPage5(_ sender: Any) {
        changeTab(to: Page5Btn)
        changePage(to: Page5TableViewController)
    }
    @IBAction func showPage6(_ sender: Any) {
        changeTab(to: Page6Btn)
        changePage(to: Page6TableViewController)
    }
    @IBAction func showPage7(_ sender: Any) {
        changeTab(to: Page7Btn)
        changePage(to: Page7TableViewController)
    }
    @IBAction func showPage8(_ sender: Any) {
        changeTab(to: Page8Btn)
        changePage(to: Page8TableViewController)
    }

    @IBAction func showPage9(_ sender: Any) {
        changeTab(to: Page9Btn)
        changePage(to: Page9TableViewController)
    }
    @IBAction func open(_ sender: Any) {
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
    
    @IBAction func connetScanner(_ sender: Any) {
        
        let push1 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let barcodeVC = push1.instantiateViewController(withIdentifier: "BarCodeViewController")
        self.navigationController?.pushViewController(barcodeVC, animated: true)
        

        
    }
    @IBAction func connectMap(_ sender: Any) {
        let push = UIStoryboard.init(name: "Map", bundle: nil)
        let mapVC = push.instantiateViewController(withIdentifier: "MapViewController")
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func connectMyLove(_ sender: Any) {
        let push2 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let loveVC = push2.instantiateViewController(withIdentifier: "MyLoveTVC")
        self.navigationController?.pushViewController(loveVC, animated: true)
        
      

    }
    
    @IBAction func connectRecord(_ sender: Any) {
        let modal2 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let recordVC = modal2.instantiateViewController(withIdentifier: "HistoryRecordTVC")
        self.navigationController?.pushViewController(recordVC, animated: true)

    }
    @IBAction func connectDrink(_ sender: Any) {
        let modal3 = UIStoryboard.init(name: "IntroductionStoryboard", bundle: nil)
        let drinkVC = modal3.instantiateViewController(withIdentifier: "ItemsViewController")
        self.navigationController?.pushViewController(drinkVC, animated: true)
        
    }
    
   
}

