//
//  MapLocationViewController.swift
//  Temperature Calculator

//  Created by Harshitha Tadinada on 10/7/2017.
//  Copyright © 2017 UGA. All right
//

import UIKit
import MapKit
import CoreLocation

class MapLocationViewController: UIViewController {
    var prev = PreviewViewController()
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var nameOfLocation: UILabel!
    @IBOutlet weak var map: MKMapView!

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var longitude: Double? = nil
    var latitude: Double? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()

        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let dateString = formatter.string(from: Date())

        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location
            latitude = currentLocation.coordinate.latitude
            longitude = currentLocation.coordinate.longitude
        }

        if(latitude != nil && longitude != nil){

            let location = CLLocationCoordinate2DMake(latitude!, longitude!)
            let span = MKCoordinateSpanMake(0.005, 0.005)
            let region = MKCoordinateRegionMake(location, span)
            map.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "\(prev.getTemperature())° F"
            map.addAnnotation(annotation)
            self.nameOfLocation.text = "\(prev.getTemperature())° F"
            nameOfLocation.textAlignment = .center
            nameOfLocation.textColor = UIColor.black
            nameOfLocation.font = UIFont.boldSystemFont(ofSize: 20
            )

            self.time.text = "\(dateString)"
            time.textAlignment = .center
            time.textColor = UIColor.black
            time.font = UIFont.boldSystemFont(ofSize: 14)
            self.view.addSubview(nameOfLocation)
            self.view.addSubview(time)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

