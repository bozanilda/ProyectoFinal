import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar el mapa con la ubicación simulada de Arequipa
        configurarMapaSimulado()
    }
    
    // MARK: - Configurar Mapa con Ubicación Simulada
    func configurarMapaSimulado() {
        // Coordenadas de Arequipa
        let simulatedCoordinates = CLLocationCoordinate2D(latitude: -16.409047, longitude: -71.537451)
        
        // Configurar la región del mapa centrada en Arequipa
        let region = MKCoordinateRegion(
            center: simulatedCoordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: true)
        
        // Agregar un pin en las coordenadas simuladas
        let annotation = MKPointAnnotation()
        annotation.coordinate = simulatedCoordinates
        annotation.title = "Mi Casa"
        annotation.subtitle = "Registrar como cochera"
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - Acción para Registrar Cochera
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        // Coordenadas simuladas de Arequipa
        let latitude = -16.409047
        let longitude = -71.537451
        
        // Simular el registro de la cochera
        print("Cochera registrada en: \(latitude), \(longitude)")
        
        // Mostrar mensaje de confirmación
        mostrarAlerta(titulo: "Éxito", mensaje: "Tu cochera se ha registrado correctamente en Arequipa.")
    }
    
    // MARK: - Mostrar Alerta
    func mostrarAlerta(titulo: String, mensaje: String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AddLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cocheraPin")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
}
