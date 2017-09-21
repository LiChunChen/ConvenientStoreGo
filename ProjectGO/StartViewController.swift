//
//  StartViewController.swift
//  BarCode
//
//  Created by gnoocl on 2017/8/31.
//  Copyright © 2017年 gnoocl. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var chBtn: UIButton!
    @IBOutlet weak var enBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RadiusBtn.radiuscorner(btn: chBtn)
        RadiusBtn.radiuscorner(btn: enBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

