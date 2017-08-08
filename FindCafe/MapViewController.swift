//
//  MapViewController.swift
//  FindCafe
//
//  Created by ChengTeLin on 2017/8/7.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import CNPPopupController

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CNPPopupControllerDelegate {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var cafeNameView: UIView!
    @IBOutlet weak var cafeAddressView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var labelCafeName: UILabel!
    @IBOutlet weak var labelCafeAddress: UILabel!
    
    var locationManager = CLLocationManager()
    
    var frame_DetailView = CGRect()
    var jsonArray = [JSON]()
    var jsonTitleArray = [String]()
    
    var selectTitle: String?
    var selectLocation : CLLocationCoordinate2D?
    var fb_urlString = ""
    var currentLocation: CLLocationCoordinate2D?
    
    var popupController: CNPPopupController?
    
    var arrayItem = ["WIFI穩定", "通常有位", "裝潢音樂", "價格便宜", "安靜程度", "咖啡好喝"]
    
    @IBAction func selectLocation(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: "請選擇縣市", preferredStyle: .actionSheet)
        
        let keelungAction = UIAlertAction(title: "基隆", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(25.131814, 121.738335)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let taipeiAction = UIAlertAction(title: "台北", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(25.050155, 121.546897)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let taoyuanAction = UIAlertAction(title: "桃園", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(24.989148, 121.313792)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let hsinchuAction = UIAlertAction(title: "新竹", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(24.801528, 120.971893)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let miaoliAction = UIAlertAction(title: "苗栗", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(24.570030, 120.822558)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let taichungAction = UIAlertAction(title: "台中", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(24.137595, 120.686831)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let changhuaAction = UIAlertAction(title: "彰化", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(24.081641, 120.538895)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let nantouAction = UIAlertAction(title: "南投", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(23.918974, 120.677728)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let yunlinAction = UIAlertAction(title: "雲林", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(23.707997, 120.543133)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let chiayiAction = UIAlertAction(title: "嘉義", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(23.482171, 120.449290)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let tainanAction = UIAlertAction(title: "台南", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(22.997159, 120.213779)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let kaohsiungAction = UIAlertAction(title: "高雄", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(22.639712, 120.302461)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let pingtungAction = UIAlertAction(title: "屏東", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(22.668897, 120.486274)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let yilanAction = UIAlertAction(title: "宜蘭", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(24.751687, 121.758962)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let hualienAction = UIAlertAction(title: "花蓮", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(23.988590, 121.605243)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let taitungAction = UIAlertAction(title: "台東", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(22.746563, 121.113718)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        let penghuAction = UIAlertAction(title: "澎湖", style: .default) { (action) in
            let coordinate = CLLocationCoordinate2DMake(23.568523, 119.579081)
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1))
            self.myMap.setRegion(region, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        
        actionSheet.addAction(keelungAction)
        actionSheet.addAction(taipeiAction)
        actionSheet.addAction(taoyuanAction)
        actionSheet.addAction(hsinchuAction)
        actionSheet.addAction(miaoliAction)
        actionSheet.addAction(taichungAction)
        actionSheet.addAction(changhuaAction)
        actionSheet.addAction(nantouAction)
        actionSheet.addAction(yunlinAction)
        actionSheet.addAction(chiayiAction)
        actionSheet.addAction(tainanAction)
        actionSheet.addAction(kaohsiungAction)
        actionSheet.addAction(pingtungAction)
        actionSheet.addAction(yilanAction)
        actionSheet.addAction(hualienAction)
        actionSheet.addAction(taitungAction)
        actionSheet.addAction(penghuAction)
        
        actionSheet.addAction(cancelAction)
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.height / 2.0, width: 1.0, height: 1.0)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func zoomCurrentLocation(_ sender: UIBarButtonItem) {
        checkAuthorizationStatus()
    }
    
    @IBAction func infoAction(_ sender: UIBarButtonItem) {
        showPopupWithStyle(.centered)
    }
    
    func showPopupWithStyle(_ popupStyle: CNPPopupStyle){
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = NSTextAlignment.center
        
        let title = NSAttributedString(string: "關於找附近咖啡廳!", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 24), NSParagraphStyleAttributeName: paragraphStyle])
        let lineOne = NSAttributedString(string: "感謝Cafe Nomad提供資料來源，更多資訊可詳閱FB與官網。", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSParagraphStyleAttributeName: paragraphStyle])
        
        let fbButton = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        fbButton.backgroundColor = UIColor(red:0.24, green:0.31, blue:0.70, alpha:1.0)
        fbButton.setTitleColor(UIColor.white, for: UIControlState())
        fbButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        fbButton.setTitle("FB粉絲專頁", for: UIControlState())
        fbButton.layer.cornerRadius = 4;
        fbButton.selectionHandler = { (button) -> Void in
            if let url = URL(string: FB_URL_STRING){
                if #available(iOS 10.0, *) {
                    let options = [UIApplicationOpenURLOptionUniversalLinksOnly: false]
                    UIApplication.shared.open(url, options: options, completionHandler: nil)
                }else {
                    UIApplication.shared.openURL(url)
                }
            }
            print("#### OPEN FB ####")
        }
        
        let webButton = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        webButton.backgroundColor = UIColor(red:0.67, green:0.47, blue:0.26, alpha:1.0)
        webButton.setTitle("官方網站", for: UIControlState())
        webButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        webButton.setTitleColor(UIColor.white, for: UIControlState())
        webButton.layer.cornerRadius = 4;
        webButton.selectionHandler = { (button) -> Void in
            if let url = URL(string: WEB_URL_STRING){
                if #available(iOS 10.0, *) {
                    let options = [UIApplicationOpenURLOptionUniversalLinksOnly: false]
                    UIApplication.shared.open(url, options: options, completionHandler: nil)
                }else {
                    UIApplication.shared.openURL(url)
                }
            }
            print("#### OPEN WEBSITE ####")
        }
        
        let button = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("關閉", for: UIControlState())
        button.backgroundColor = UIColor.init(colorLiteralRed: 0.46, green: 0.8, blue: 1.0, alpha: 1.0)
        button.layer.cornerRadius = 4;
        button.selectionHandler = { (button) -> Void in
            self.popupController?.dismiss(animated: true)
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.attributedText = title
        
        let lineOneLabel = UILabel()
        lineOneLabel.numberOfLines = 0;
        lineOneLabel.attributedText = lineOne;
        
        let popupController = CNPPopupController(contents:[titleLabel, lineOneLabel, fbButton, webButton, button])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = popupStyle
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myMap.delegate = self
        myMap.showsUserLocation = true
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        
        let itemSize = UIScreen.main.bounds.width / 2 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: itemSize, height: 47)
        myCollectionView.collectionViewLayout = layout
        
        getAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        frame_DetailView = detailView.frame
        myMap.frame = self.view.frame
        detailView.frame = CGRect(origin: CGPoint(x: view.frame.origin.x, y: view.frame.maxY), size: detailView.frame.size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuthorizationStatus()
    }
    
    func checkAuthorizationStatus(){
        
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            
        }else if CLLocationManager.authorizationStatus() == .denied {
            let alertController = UIAlertController(
                title: "請開啟定位權限",
                message:"如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                preferredStyle: .alert)
            
            let goSettingAction = UIAlertAction(title: "前往", style: .default, handler: { (action) in
                guard let url = URL(string: UIApplicationOpenSettingsURLString) else{ return }
                
                UIApplication.shared.openURL(url)
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(goSettingAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            zoomCurrentLocationOnMap()
            locationManager.startUpdatingLocation()
        }
    }
    
    func zoomCurrentLocationOnMap(){
        if let coordinate = locationManager.location?.coordinate{
            let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.005, 0.005))
            self.myMap.setRegion(region, animated: true)
        }
    }
    
    func getAPI(){
        APIManager.shared.getCoffeeAPI { (json) in
            if json != nil{
                if let coffeeShopList = json.array{
                    
                    for coffeeShop in coffeeShopList{
                        self.jsonArray.append(coffeeShop)
                        
                        if let shopName = coffeeShop["name"].string{
                            self.jsonTitleArray.append(shopName)
                            
                            guard let latString = coffeeShop["latitude"].string, let lngString = coffeeShop["longitude"].string else{ return }
                            
                            if let lat = CLLocationDegrees(latString){
                                if let lng = CLLocationDegrees(lngString){
                                    self.setAnnotation(lat: lat, lng: lng, name: shopName)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        print(locations)
        
        if locations.count > 0{
            if let lastLocation = locations.last{
                currentLocation = lastLocation.coordinate
                
                let region = MKCoordinateRegionMake(currentLocation!, MKCoordinateSpanMake(0.005, 0.005))
                self.myMap.setRegion(region, animated: true)
            }
        }
        
        //        if currentLocation != nil{
        //            manager.stopUpdatingLocation()
        //        }
    }
    
    func setAnnotation(lat: CLLocationDegrees, lng: CLLocationDegrees, name: String){
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = lat
        annotation.coordinate.longitude = lng
        annotation.title = name
        self.myMap.addAnnotation(annotation)
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var cafeAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if cafeAnnotation == nil {
            cafeAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        
        cafeAnnotation?.annotation = annotation
        cafeAnnotation?.image = UIImage(named: "icons8-location_filled-50")
        
        return cafeAnnotation
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if view.annotation is MKUserLocation{
            print("This is user location!")
            return
        }
        
        if let location = view.annotation?.coordinate{
            selectLocation = location
        }
        
        if let titleString = view.annotation?.title{
            selectTitle = titleString
            labelCafeName.text = selectTitle
            labelCafeName.sizeToFit()
        }
        
        UIView.animate(withDuration: 0.2) {
            self.detailView.frame = self.frame_DetailView
            
            var mapFrame = self.myMap.frame
            mapFrame.size.height = self.detailView.frame.origin.y
            self.myMap.frame = mapFrame
        }
        
        let indexNumber = jsonTitleArray.index(of: selectTitle!)
        
        let shopJSONData = jsonArray[indexNumber!]
        
        print(shopJSONData)
        
        if let address = shopJSONData["address"].string{
            labelCafeAddress.text = address
            labelCafeAddress.sizeToFit()
        }
        
        if let url_string = shopJSONData["url"].string{
            fb_urlString = url_string
        }
        
        myCollectionView.reloadData()
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        UIView.animate(withDuration: 0.2) {
            
            self.detailView.frame = CGRect(origin: CGPoint(x: self.detailView.frame.origin.x, y: self.view.frame.maxY), size: self.detailView.frame.size)
            
            self.myMap.frame = self.view.frame
        }
    }
    
    @IBAction func openFB(_ sender: UIButton) {
        if let url = URL(string: fb_urlString){
            if #available(iOS 10.0, *) {
                let options = [UIApplicationOpenURLOptionUniversalLinksOnly: false]
                UIApplication.shared.open(url, options: options, completionHandler: nil)
            }else {
                UIApplication.shared.openURL(url)
            }
        }else{
            let alert = UIAlertController(title: "錯誤", message: "該店家目前無Facebook粉絲專頁", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func openNavigation(_ sender: UIButton) {
        if currentLocation == nil{
            print("currentLocation == nil")
            return
        }
        
        if #available(iOS 10.0, *) {
            let markA = MKPlacemark(coordinate: currentLocation!)
            let markB = MKPlacemark(coordinate: selectLocation!)
            
            let miA = MKMapItem(placemark: markA)
            let miB = MKMapItem(placemark: markB)
            miA.name = "我的位置"
            miB.name = selectTitle
            
            let routes = [miA, miB]
            
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
            MKMapItem.openMaps(with: routes, launchOptions: options)
        } else {
            let markA = MKPlacemark(coordinate: currentLocation!, addressDictionary: nil)
            let markB = MKPlacemark(coordinate: selectLocation!, addressDictionary: nil)
            
            let miA = MKMapItem(placemark: markA)
            let miB = MKMapItem(placemark: markB)
            miA.name = "我的位置"
            miB.name = selectTitle
            
            let routes = [miA, miB]
            
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
            MKMapItem.openMaps(with: routes, launchOptions: options)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DetailCollectionViewCell
        
        cell.labelOptionName.text = arrayItem[indexPath.row]
        cell.labelOptionName.sizeToFit()
        cell.imgStar.image = UIImage(named: "icons8-filled_star-25")
        
        if selectTitle != nil{
            let indexNumber = jsonTitleArray.index(of: selectTitle!)
            
            let shopJSONData = jsonArray[indexNumber!]
            
            let wifi_star = shopJSONData["wifi"].int
            let seat_star = shopJSONData["seat"].int
            let music_star = shopJSONData["music"].int
            let cheap_star = shopJSONData["cheap"].int
            let quiet_star = shopJSONData["quiet"].int
            let tasty_star = shopJSONData["tasty"].int
            
            switch indexPath.row {
            case 0:
                cell.labelStarNumber.text = "\(wifi_star!)"
            case 1:
                cell.labelStarNumber.text = "\(seat_star!)"
            case 2:
                cell.labelStarNumber.text = "\(music_star!)"
            case 3:
                cell.labelStarNumber.text = "\(cheap_star!)"
            case 4:
                cell.labelStarNumber.text = "\(quiet_star!)"
            case 5:
                cell.labelStarNumber.text = "\(tasty_star!)"
            default:
                cell.labelStarNumber.text = "Nothing"
            }
            
        }
        
        return cell
    }

}
