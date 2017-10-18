//
//  ViewController.swift
//  ShopMapAPI
//
//  Created by Michelle Chen on 2017/9/14.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var isFirstLocationReceived = false
    var shopList = [Shop]()
    var address = ""
    var myCurrentLocation = CLLocationCoordinate2D()
    
    
    @IBOutlet weak var shopSelectSeg: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - check if network works
    func checkNetworkConnection(){
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            let alert = UIAlertController(title: "嗚呼", message: "沒有網路連線", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func selectShop(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            mapView.removeAnnotations(mapView.annotations)
            locationManager.startUpdatingLocation()
            getAddressFromCoordinate(pdblLatitude: String(myCurrentLocation.latitude), withLongitude: String(myCurrentLocation.longitude)) { (address) in
                self.address = address
                loadData(url:getURL(city: address), completion: { (shopList) in
                    self.addShopAnnotation(list: shopList)
                })
                
            }
            print("show all annotation")
        case 1:
            mapView.removeAnnotations(mapView.annotations)
            getAddressFromCoordinate(pdblLatitude: String(myCurrentLocation.latitude), withLongitude: String(myCurrentLocation.longitude), completion: { (address) in
                self.address = address
                loadData(url:getURL(city: address), completion: { (shopList) in
                    for shop in shopList{
                        if shop.category == "7-11"{
                            self.categoryAddAnnotaiton(shop: shop, imageName: "pointGreen")
                        }
                    }
                })
                
            })
            print("show 7-11")
        case 2:
            mapView.removeAnnotations(mapView.annotations)
            getAddressFromCoordinate(pdblLatitude: String(myCurrentLocation.latitude), withLongitude: String(myCurrentLocation.longitude), completion: { (address) in
                self.address = address
                loadData(url:getURL(city: address), completion: { (shopList) in
                    for shop in shopList{
                        if shop.category == "FamilyMart"{
                            self.categoryAddAnnotaiton(shop: shop, imageName: "pointBlue")
                        }
                    }
                })
                
            })
            print("show FamilyMart")
        case 3:
            mapView.removeAnnotations(mapView.annotations)
            getAddressFromCoordinate(pdblLatitude: String(myCurrentLocation.latitude), withLongitude: String(myCurrentLocation.longitude), completion: { (address) in
                self.address = address
                loadData(url:getURL(city: address), completion: { (shopList) in
                    for shop in shopList{
                        if shop.category == "Hi-Life"{
                            self.categoryAddAnnotaiton(shop: shop, imageName: "pointRed")
                        }
                    }
                })
                
            })
            print("show Hi-Life")
        case 4:
            mapView.removeAnnotations(mapView.annotations)
            getAddressFromCoordinate(pdblLatitude: String(myCurrentLocation.latitude), withLongitude: String(myCurrentLocation.longitude), completion: { (address) in
                self.address = address
                loadData(url:getURL(city: address), completion: { (shopList) in
                    for shop in shopList{
                        if shop.category == "OK"{
                            self.categoryAddAnnotaiton(shop: shop, imageName: "pointOk")
                        }
                    }
                })
                
            })
            print("show OK")
        default:
            mapView.removeAnnotations(mapView.annotations)
            getAddressFromCoordinate(pdblLatitude: String(myCurrentLocation.latitude), withLongitude: String(myCurrentLocation.longitude)) { (address) in
                self.address = address
                loadData(url:getURL(city: address), completion: { (shopList) in
                    self.addShopAnnotation(list: shopList)
                })
            }
            print("show all annotation")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        
        //prepare locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.startUpdatingLocation()
        self.title = "離我最近的超商"
        checkNetworkConnection()

       
        
    }


    
    // MARK: - Get current location coordinate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get current location
        guard let currentLocation = locations.last else{
            return
        }
        let coordinate = currentLocation.coordinate
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            print(currentLocation)
        }
        NSLog("Lat:\(coordinate.latitude),Lon:\(coordinate.longitude)")
        let lat = coordinate.latitude
        let lng = coordinate.longitude
        myCurrentLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        //download your-city-location-data
        DispatchQueue.once(token: "LocateYourCity"){
            
            getAddressFromCoordinate(pdblLatitude: String(coordinate.latitude), withLongitude: String(coordinate.longitude)) { (address) in
                self.address = address
                loadData(url:getURL(city: address), completion: { (shopList) in
                    self.addShopAnnotation(list: shopList)
                })
                
            }
            
        }
            let span = MKCoordinateSpanMake(0.001,0.001)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        
            self.mapView.showsUserLocation = true
            manager.stopUpdatingLocation()
        }
    
    // MARK: - convert coordinate to address
    func getAddressFromCoordinate(pdblLatitude: String, withLongitude pdblLongitude: String, completion: @escaping (String) -> Void){
        var center = CLLocationCoordinate2D()
        let lat = Double("\(pdblLatitude)")!
        let lon = Double("\(pdblLongitude)")!
        let ceo = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        //change device language to show chinese name of city
        let defaults = UserDefaults.standard
        let lans = defaults.object(forKey: "AppleLanguages")
        //繁體中文
        defaults.set(["zh-TW"], forKey: "AppleLanguages")
        
        let loc = CLLocation(latitude:center.latitude, longitude: center.longitude)
        var address = ""
        
        let locale = Locale(identifier: "zh-TW")
        
        ceo.reverseGeocodeLocation(loc, preferredLocale: locale, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    //print city
                    let pm = placemarks![0]
                        if pm.subAdministrativeArea != nil{
                            address += pm.subAdministrativeArea!
                        }
                    
                }
                completion(address)
                
                //restore device language
                defaults.set(lans, forKey: "AppleLanguages")
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.clear()
    }
    

    
    
    // MARK: - add shop to annotation
    func addShopAnnotation(list:Array<Shop>){
        for shop in list{
            if shop.category == "7-11"{
                categoryAddAnnotaiton(shop: shop, imageName: "pointGreen")
            }
            else if shop.category == "FamilyMart"{
                categoryAddAnnotaiton(shop: shop, imageName: "pointBlue")
            }
            else if shop.category == "Hi-Life"{
                categoryAddAnnotaiton(shop: shop, imageName: "pointRed")
            }
            else if shop.category == "OK"{
                categoryAddAnnotaiton(shop: shop, imageName: "pointOk")
            }
            else{
                print("do nothing")
            }
        }
        
    }
    
    func categoryAddAnnotaiton(shop:Shop, imageName:String){
        let annotation = CustomPointAnnotation()
        if shop.coordinate != nil {
            var shopCoordinate = shop.coordinate!
            if let latNum = shopCoordinate["lat"] as? Double, let lngNum = shopCoordinate["lng"] as? Double {
                let coordinate = CLLocationCoordinate2D(latitude: latNum, longitude: lngNum)
                annotation.coordinate = coordinate
                annotation.title = shop.title
                annotation.subtitle = shop.address
                annotation.imageName = imageName
            }
            self.mapView.addAnnotation(annotation)
        }
        else{
            print("do nothing")
        }
        
    }

    
    
    // MARK: - put annotation on map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "store"
        var result = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if result == nil{
            result = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        else{
            result?.annotation = annotation
        }
        result?.canShowCallout = true
        let cpa = annotation as! CustomPointAnnotation
        let image = UIImage(named:cpa.imageName)
        result?.image = image
        
        //Prepare LeftCalloutAccessoryView
        let imageView = UIImageView(image: image)
        result?.leftCalloutAccessoryView = imageView
        
        return result
    }
    
 
    @IBAction func showMyLocation(_ sender: Any){
        locationManager.startUpdatingLocation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

