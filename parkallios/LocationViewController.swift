//
//  LocationViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 27/11/24.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configuración inicial del CLLocationManager
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
            // Verificar permisos de ubicación y mostrar la ubicación del usuario
            checkLocationAuthorization()
            
            // Estas líneas activan la visualización del punto del usuario en el mapa
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        }
        
        // Verificar estado de autorización
        func checkLocationAuthorization() {
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
            case .denied, .restricted:
                showAlert(title: "Permisos Requeridos", message: "Habilita los permisos de ubicación en Configuración para ver tu ubicación.")
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        }
        
        // Manejar actualizaciones de ubicación
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let region = MKCoordinateRegion(
                    center: location.coordinate,
                    latitudinalMeters: 1000,
                    longitudinalMeters: 1000
                )
                mapView.setRegion(region, animated: true)
            }
        }
        
        // Mostrar alerta si los permisos son denegados
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Ir a Configuración", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
