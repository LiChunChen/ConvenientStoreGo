//
//  ChangeViewController.swift
//  GoGoGo
//
//  Created by gnoocl on 2017/9/6.
//  Copyright © 2017年 gnoocl. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController,UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var codePageControl: UIPageControl!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //計算出目前滑動的頁數
        let currentPageNumber = Int(round(myScrollView.contentOffset.x / scrollView.frame.size.width))
        //設定pageControl顯示的頁數
        codePageControl.currentPage = currentPageNumber
    }
    
    @objc func codePageControlAction(_ sender: UIPageControl) {
        
        let currentPageNumber = sender.currentPage //得到選取的頁面
        let width = myScrollView.frame.size.width
        //把ScrollView的寬度存在width變數之後，依照目前的頁面算出需要偏離的距離
        let offset = CGPoint(x: width * CGFloat(currentPageNumber), y: 0)
        //讓ScrollView移動到正確的位置
        myScrollView.setContentOffset(offset, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        //設定contentSize.width
        myScrollView.contentSize.width = myScrollView.frame.width * 5
        //設定三個畫面的顏色
        let viewColors = [UIColor.red,UIColor.green,UIColor.blue,UIColor.black,UIColor.lightGray]
        //在ScrollView上加入三個畫面
        for i in 0..<5{
            let oneView = UIView(
                frame: CGRect(
                    x: CGFloat(i) * myScrollView.frame.size.width,
                    y: 0,
                    width: myScrollView.frame.size.width,
                    height: myScrollView.frame.size.height))
            oneView.backgroundColor = viewColors[i]
            myScrollView.addSubview(oneView)
        }
        //設定pageEnable
        myScrollView.isPagingEnabled = true
        //設定bounce
        myScrollView.bounces = false
        
        //建立PageControl
        codePageControl = UIPageControl(frame: CGRect(x: view.frame.size.width/2 - 30, y: view.frame.size.height - 50, width: 60, height: 37))
        //設定PageControl顏色
        codePageControl.pageIndicatorTintColor = UIColor.black
        //設定目前頁面的顏色
        codePageControl.currentPageIndicatorTintColor = UIColor.lightGray
        //設定總頁數
        codePageControl.numberOfPages = 5
        //設定目前的頁數
        codePageControl.currentPage = 0
        //設定改動頁數後要執行的方法
        codePageControl.addTarget(self, action: #selector(codePageControlAction(_:)), for: .valueChanged)
        //把PageControl加到畫面上
        view.addSubview(codePageControl)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
