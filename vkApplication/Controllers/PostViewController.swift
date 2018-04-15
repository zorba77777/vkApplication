//
//  PostViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 01/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import CoreLocation

class PostViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var post: UITextView!
    
    var postsSender = VkRequestEnum.post
    let vkHelper = VkRequestHelper(downloadType: .post)
    let locationManager = CLLocationManager()
    
    var latitude: String?
    var longitude: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorType = error._code == CLError.denied.rawValue ? "Access Denied": "Error \(error._code)"
        let alertController = UIAlertController(title: "Location Manager Error", message: errorType, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in })
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            self.latitude = String(format: "%g\u{00B0}", newLocation.coordinate.latitude)
            self.longitude = String(format: "%g\u{00B0}", newLocation.coordinate.longitude)
            
            if newLocation.horizontalAccuracy < 0 {
                // invalid accuracy
                return
            }
            
            if newLocation.horizontalAccuracy > 100 ||
                newLocation.verticalAccuracy > 50 {
                // accuracy radius is so large, we don't want to use it
                return
            }
        }
    }

    @IBAction func addLocation(_ sender: UIButton) {
        let coordinates = "\nlatitude = \(self.latitude!) \nlongitude = \(self.longitude!)"
        self.post.text = self.post.text + coordinates
    }
    
    @IBAction func sendPost(_ sender: UIButton) {
        guard let message = post.text else {
            post.text = "Message to post is missed"
            print("Message to post is missed")
            return
        }
        if self.vkHelper.sendRequestToVk(message: message) {
            post.text = "Post has been added"
        } else {
            post.text = "Post hasn't been added"
        }
    }    
}
