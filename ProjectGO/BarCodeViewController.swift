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

    @IBOutlet weak var barcodeFrame: UIImageView!
    
    let lightDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    var isLightOn: Bool = false
    
    // 使用的裝置
    var device:AVCaptureDevice!
    
    var input:AVCaptureDeviceInput!
    var output:AVCaptureMetadataOutput!
    var session:AVCaptureSession!
    var preview:AVCaptureVideoPreviewLayer!
    var isRunning = false
    
    @IBOutlet weak var readBarCodeIBOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // info: privace of camera's string
        // This app requires camera access to function properly
        // 此應用程序需要相機訪問才能正常工作

        fromCamera()
        view.bringSubview(toFront: readBarCodeIBOutlet)
    }
    
    //通过摄像头扫描
    func fromCamera() {
        
            
        // 會管理從攝像頭獲取的數據——將輸入的數據轉為可以使用的輸出
        session = AVCaptureSession()
        
        // 設定物理設備和其他屬性(取得照相機裝置)
        // self.device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        // builtInMicrophone: 內建的相機裝置
        device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back)            

        
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
        output.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code,
                                      AVMetadataObjectTypeEAN8Code,
                                      AVMetadataObjectTypeCode128Code,
                                      AVMetadataObjectTypeCode39Code,
                                      AVMetadataObjectTypeCode93Code]
        // 取得螢幕的size
        let windowSize = UIScreen.main.bounds.size
        // 計算掃描的區域範圍
        let scanRect = CGRect(x: barcodeFrame.frame.origin.y/windowSize.height, y: barcodeFrame.frame.origin.x/windowSize.width, width: barcodeFrame.bounds.height/windowSize.height, height: barcodeFrame.bounds.width/windowSize.width)
        // 設定掃描的區域範圍
        output.rectOfInterest = scanRect
        
        preview = AVCaptureVideoPreviewLayer(session: session)
        preview.frame = view.layer.bounds
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
        view.layer.addSublayer(preview)
//        barcodeFrame.layer.addSublayer(preview)
//        view.addSubview(blurEffectView)
//        view.bringSubview(toFront: blurEffectView)
        
        
        
        // 一定要將 barcodeFrame 提到最前面，才會顯示出來
        view.bringSubview(toFront: barcodeFrame)
       
            
//            // Allow the view to resize freely
//            self.highlightView.autoresizingMask =   UIViewAutoresizing.FlexibleTopMargin |
//                UIViewAutoresizing.FlexibleBottomMargin |
//                UIViewAutoresizing.FlexibleLeftMargin |
//                UIViewAutoresizing.FlexibleRightMargin
//            
//            // Select the color you want for the completed scan reticle
//            self.highlightView.layer.borderColor = UIColor.greenColor().CGColor
//            self.highlightView.layer.borderWidth = 3

            
        //开始捕获
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
    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [Any]!,
                       from connection: AVCaptureConnection!) {
        
        guard let barcodeData = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
            print("Can not get metadataObjects.")
            return
        }
        
        print(barcodeData)
        
//        let barcodeString = barcodeData.stringValue
//        print(barcodeString ?? "Transform To String Fail!")
        guard let barcodeString = barcodeData.stringValue else {
            print("Transform To String Fail!")
            return
        }
        
        print(barcodeString)
        session.stopRunning()
        isRunning = false
    }
    
    @IBAction func readBarCode(_ sender: Any) {
        
        guard isRunning != true else {
            return
        }
        
        session.startRunning()
        isRunning = true
        
    }
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
}


