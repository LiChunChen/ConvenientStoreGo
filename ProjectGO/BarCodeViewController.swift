//
//  BarCodeViewController.swift
//  BarCode
//
//  Created by ChenLiChun on 2017/9/5.
//  Copyright © 2017年 ChenLiChun. All rights reserved.
//

import UIKit
import AVFoundation

class BarCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var rightLC: NSLayoutConstraint!
    var menuShowing = true
    
    @IBOutlet weak var barcodeFrame: UIImageView!
    @IBOutlet weak var lightBtn: UIButton!
    
    let lightDevice = AVCaptureDevice.default(for: AVMediaType.video)
    var isLightOn: Bool = false
    
    // 使用的裝置
    var device:AVCaptureDevice!
    
    var input:AVCaptureDeviceInput!
    var output:AVCaptureMetadataOutput!
    var session:AVCaptureSession!
    var preview:AVCaptureVideoPreviewLayer!
    var isRunning = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // info: privace of camera's string
        // This app requires camera access to function properly
        // 此應用程序需要相機訪問才能正常工作
    
        self.navigationItem.leftBarButtonItem=nil
        self.navigationItem.hidesBackButton=true
        
        fromCamera()
        view.bringSubview(toFront: sideView)
        
        view.bringSubview(toFront: lightBtn)
    }
 
    
    //透過相機來掃條碼
    func fromCamera() {
        
        
        // 會管理從攝像頭獲取的數據——將輸入的數據轉為可以使用的輸出
        session = AVCaptureSession()
        
        // 設定物理設備和其他屬性(取得照相機裝置)
        // builtInMicrophone: 內建的相機裝置
        device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        
        do {
            // 從設備中獲取數據
            input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        }catch {
            scanningNotPossible()
        }
        
        // Sets the delegate and dispatch queue to use handle callbacks
        output = AVCaptureMetadataOutput()
        // 會將捕獲到的數據通過串行隊列發送給 delegate 對象
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(output)
        // 支援的條碼類型 一定要先加到 session 之後才能做設定
        output.metadataObjectTypes = [.ean13, .ean8, .code128, .code39, .code93]
        
        // 取得螢幕的size
        let windowSize = UIScreen.main.bounds.size
        // 計算掃描的區域範圍
        let scanRect = CGRect(x: barcodeFrame.frame.origin.y/windowSize.height, y: barcodeFrame.frame.origin.x/windowSize.width, width: barcodeFrame.bounds.height/windowSize.height, height: barcodeFrame.bounds.width/windowSize.width)
        // 設定掃描的區域範圍
        output.rectOfInterest = scanRect
        
        preview = AVCaptureVideoPreviewLayer(session: session)
        preview.frame = view.layer.bounds
        preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(preview)
        
        // 一定要將 barcodeFrame 提到最前面，才會顯示出來
        view.bringSubview(toFront: barcodeFrame)
        
        //開始捕獲
        session.startRunning()
        isRunning = true
        
    }
    
    func scanningNotPossible() {
        // Let the user know that scanning isn't possible with the current device.
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        session = nil
    }
    
    //摄像头捕获
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard metadataObjects.count > 0 else {
            NSLog("No metadata available.")
            return
        }
        
        // 轉型成為 AVMetadataMachineReadableCodeObject，他的父為AVMetadataObject
        guard let metadata = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            NSLog("Not valid metadata object.")
            return
        }
     
        guard let barcodeString = metadata.stringValue else {
            print("Transform To String Fail!")
            return
        }
        
        session.stopRunning()
        isRunning = false
        
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let barcode = Int(barcodeString)
            viewcontroller.barcodes = [barcode!]
           self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    @IBAction func openMenu(_ sender: Any) {
        if (menuShowing) {
            rightLC.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            rightLC.constant = -140
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing

    }
    @IBAction func openLove(_ sender: Any) {
        let push2 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let loveVC = push2.instantiateViewController(withIdentifier: "MyLoveTVC")
        self.navigationController?.pushViewController(loveVC, animated: true)
    }
    @IBAction func openMap(_ sender: Any) {
        let push = UIStoryboard.init(name: "Map", bundle: nil)
        let mapVC = push.instantiateViewController(withIdentifier: "MapViewController")
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    @IBAction func openScan(_ sender: Any) {
        let push1 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let barcodeVC = push1.instantiateViewController(withIdentifier: "BarCodeViewController")
        self.navigationController?.pushViewController(barcodeVC, animated: true)
        
    }
    @IBAction func openRecord(_ sender: Any) {
        let modal2 = UIStoryboard.init(name: "BarcodeStoryboard", bundle: nil)
        let recordVC = modal2.instantiateViewController(withIdentifier: "HistoryRecordTVC")
        self.navigationController?.pushViewController(recordVC, animated: true)

    }
    @IBAction func openDrink(_ sender: Any) {
        let modal3 = UIStoryboard.init(name: "IntroductionStoryboard", bundle: nil)
        let drinkVC = modal3.instantiateViewController(withIdentifier: "ItemsViewController")
        self.navigationController?.pushViewController(drinkVC, animated: true)
        
    }
 
    //    func captureOutput(_ captureOutput: AVCaptureOutput!,
//                       didOutputMetadataObjects metadataObjects: [Any]!,
//                       from connection: AVCaptureConnection!) {
//
//        guard let barcodeData = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
//            print("Can not get metadataObjects.")
//            return
//        }
//
//
//    }
    
  
    
    @IBAction func lightBtn(_ sender: Any) {
        
        do {
            //修改鎖定設備以便進行手電筒狀態
            try lightDevice?.lockForConfiguration()
        } catch {
            print("error")
        }
        if isLightOn {
            
            lightDevice?.torchMode = .off
            isLightOn = false
        } else {
            
            lightDevice?.torchMode = .on
            isLightOn = true
        }
        lightDevice?.unlockForConfiguration()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        do {
            //修改鎖定設備以便進行手電筒狀態
            try lightDevice?.lockForConfiguration()
        } catch {
            print("error")
        }
        if isLightOn {
            lightDevice?.torchMode = .off
        }
        lightDevice?.unlockForConfiguration()
    }
}


