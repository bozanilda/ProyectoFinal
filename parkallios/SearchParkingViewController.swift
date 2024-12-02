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
    @IBOutlet weak var availableParkingButton: UIButton!
    // Coordenadas simuladas para la ubicación actual
    let simulatedLocation = CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428) // Lima, Perú
    
    // Coordenadas de "cocheras disponibles"
    let parkingLocations = [
        ("Cochera Disponible 1", CLLocationCoordinate2D(latitude: -12.047, longitude: -77.043)),
        ("Cochera Disponible 2", CLLocationCoordinate2D(latitude: -12.048, longitude: -77.044)),
        ("Cochera Disponible 3", CLLocationCoordinate2D(latitude: -12.045, longitude: -77.045)),
        ("Cochera Disponible 4", CLLocationCoordinate2D(latitude: -12.046, longitude: -77.042)),
        ("Cochera Disponible 5", CLLocationCoordinate2D(latitude: -12.049, longitude: -77.040)),
        ("Cochera Disponible 6", CLLocationCoordinate2D(latitude: -12.050, longitude: -77.041)),
        ("Cochera Disponible 7", CLLocationCoordinate2D(latitude: -12.044, longitude: -77.046)),
        ("Cochera Disponible 8", CLLocationCoordinate2D(latitude: -12.048, longitude: -77.047)),
        ("Cochera Disponible 9", CLLocationCoordinate2D(latitude: -12.046, longitude: -77.044)),
        ("Cochera Disponible 10", CLLocationCoordinate2D(latitude: -12.047, longitude: -77.048)),
        ("Cochera Disponible 11", CLLocationCoordinate2D(latitude: -12.042, longitude: -77.041)),
        ("Cochera Disponible 12", CLLocationCoordinate2D(latitude: -12.051, longitude: -77.043)),
        ("Cochera Disponible 13", CLLocationCoordinate2D(latitude: -12.045, longitude: -77.049)),
        ("Cochera Disponible 14", CLLocationCoordinate2D(latitude: -12.043, longitude: -77.050)),
        ("Cochera Disponible 15", CLLocationCoordinate2D(latitude: -12.048, longitude: -77.042))
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        availableParkingButton.isHidden = true // Esconde el botón al inicio
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

                // Mostrar mensaje emergente
                let alert = UIAlertController(
                    title: "Cochera Seleccionada",
                    message: "Ir a la lista de cocheras disponibles para más información.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
                    self.availableParkingButton.isHidden = false // Mostrar el botón
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }

    // Acción para el botón de "Lista de cocheras disponibles"
        @IBAction func showParkingList(_ sender: UIButton) {
            performSegue(withIdentifier: "showParkingList", sender: nil)
        }
        }

