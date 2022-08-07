//
//  ViewController.swift
//  Navigation
//
//  Created by саргашкаева on 7.08.2022.
//
import CoreLocation
import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    
    // MARK: - Propeties
    let apiKey = GMSServices.provideAPIKey("AIzaSyDyN2TEhfGel6Br_mZuQ1zn-_rN2KCUBsU")
    let manager = CLLocationManager()
    
    
    // MARK: - Markers
    var mapView: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    var aucaMarker: GMSMarker = {
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 42.8106, longitude: 74.6274)
        marker.title = "American University in Central Asia"
        marker.snippet = "Educational Institution"
        return marker
    } ()
    
    var kyrKazMarker: GMSMarker = {
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 42.8417, longitude: 74.6474)
        marker.title = "Kyrgyz-Kazakh University"
        marker.snippet = "Educational Institution"
        return marker
    } ()
    
    var plaza: GMSMarker = {
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 42.8742, longitude: 74.6179)
        marker.title = "Dordoi Plaza"
        marker.snippet = "Shopping Centre"
        return marker
    } ()
    
    var tsum: GMSMarker {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 42.8762, longitude: 74.6145)
        marker.title = "Tsum"
        marker.snippet = "Shopping centre"
        return marker
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        setConstraints()
        addMarkers()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    // MARK: - Helpers
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func addSubViews() {
        view.addSubview(mapView)
    }
    
    private func addMarkers() {
        aucaMarker.map = mapView
        kyrKazMarker.map = mapView
        plaza.map = mapView
        tsum.map = mapView
    }
    
    private func render(_ location: CLLocation) {
        let camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 10)
        mapView.camera = camera
    }
}


// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            render(location)
            mapView.isMyLocationEnabled = true
            manager.stopUpdatingLocation()
        }
    }
}




