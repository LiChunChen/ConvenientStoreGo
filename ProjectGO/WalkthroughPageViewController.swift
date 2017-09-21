//
//  WalkthroughPageViewController.swift
//  GoGoGo
//
//  Created by gnoocl on 2017/9/9.
//  Copyright © 2017年 gnoocl. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    var pageHeadings=["Scanner3456789","Map","Product Detail","Use APP"]
    var pageImages = ["scaner","map","product","LetGo"]
    var pageContent = ["scanner","map","product","LetGo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func contentViewController(at index:Int)->WalkthroughContentViewController?{
        if index<0 || index>=pageHeadings.count{
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController{
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return pageHeadings.count
//    }
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController{
//            return pageContentViewController.index
//        }
//        return 0
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
