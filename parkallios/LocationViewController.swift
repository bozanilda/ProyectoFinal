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
    // Coordenada simulada para Arequipa, Perú
    let simulatedLocation = CLLocationCoordinate2D(latitude: -16.409047, longitude: -71.537451)
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configuración inicial del CLLocationManager
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            // Mostrar ubicación simulada
                    simulateLocation()
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
        
    //Manejar actualizaciones de ubicación
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            // Este método no hará nada porque vamos a usar una ubicación simulada
        }
        
        // Simular ubicación
        func simulateLocation() {
            print("Simulando ubicación: Arequipa, Perú")
            
            // Configurar región simulada
            let region = MKCoordinateRegion(
                center: simulatedLocation,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            mapView.setRegion(region, animated: true)
            
            // Agregar un marcador en la ubicación simulada
            let annotation = MKPointAnnotation()
            annotation.coordinate = simulatedLocation
            annotation.title = "Ubicacion actual"
            annotation.subtitle = "Arequipa, Perú"
            mapView.addAnnotation(annotation)
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
