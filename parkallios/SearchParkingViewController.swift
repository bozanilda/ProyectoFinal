//
//  SearchParkingViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 30/11/24.
//

import UIKit
import MapKit

class SearchParkingViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    // Coordenadas simuladas para la ubicación actual
    let simulatedLocation = CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428) // Lima, Perú
    
    // Coordenadas de "casas con cocheras"
    let parkingLocations = [
        ("Casa A", CLLocationCoordinate2D(latitude: -12.047, longitude: -77.043)), // Ejemplo de una cochera
        ("Casa B", CLLocationCoordinate2D(latitude: -12.048, longitude: -77.044)), // Ejemplo de otra cochera
        ("Casa C", CLLocationCoordinate2D(latitude: -12.045, longitude: -77.045))  // Ejemplo adicional
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        simulateCurrentLocation()
        addParkingLocations()
    }

    func simulateCurrentLocation() {
        print("Ubicación simulada: Latitud: \(simulatedLocation.latitude), Longitud: \(simulatedLocation.longitude)")
        
        // Mostrar la ubicación simulada en el mapa
        let region = MKCoordinateRegion(center: simulatedLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // Añadir un marcador para la ubicación simulada
        let annotation = MKPointAnnotation()
        annotation.coordinate = simulatedLocation
        annotation.title = "Ubicación Actual Simulada"
        mapView.addAnnotation(annotation)
    }

    func addParkingLocations() {
        // Agregar marcadores de las "casas con cochera" en el mapa
        for (title, coordinate) in parkingLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = title
            mapView.addAnnotation(annotation)
        }
    }

    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let title = view.annotation?.title else { return }
        
        // Verificar si es una cochera seleccionada
        if let parkingTitle = title {
            print("Seleccionaste: \(parkingTitle)")
            
            // Simular la navegación a otra vista
            performSegue(withIdentifier: "showParkingDetail", sender: parkingTitle)
        }
    }

    
    }

