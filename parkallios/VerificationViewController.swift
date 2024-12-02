//
//  VerificationViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 29/11/24.
//

import UIKit

class VerificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var acceptButton: UIButton!
    
    // Vehículo seleccionado (recibido desde VehicleTypeViewController)
    var selectedVehicle: String?

    // Datos de las opciones de verificación
    let verificationOptions = [
        "Información básica",
        "Licencia de conducir",
        "Confirmación de ID",
        "Información acerca del vehículo",
        "SOAT",
        "Carta de antecedentes no penales",
        "Código de referencia"
    ]
    // Identificadores de segues
        let segueIdentifiers = [
            "showInformacionBasica",
            "showLicenciaConducir",
            "showConfirmacionID",
            "showInformacionVehiculo",
            "showSOAT",
            "showAntecedentes",
            "showCodigoReferencia"
        ]
    // Indica si cada opción está completada
    var completionStatus = [false, false, false, false, false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuración del TableView
        tableView.delegate = self
        tableView.dataSource = self

        // Configurar el botón Aceptar
        acceptButton.layer.cornerRadius = 8
        updateAcceptButtonState()

        // Mostrar el vehículo seleccionado en el título
        if let vehicle = selectedVehicle {
            self.title = "Verificación: \(vehicle)"
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verificationOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VerificationCell", for: indexPath)
        
        // Configurar el texto de la celda
        cell.textLabel?.text = verificationOptions[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .darkGray

        // Configurar el accesorio con flecha o check
                if completionStatus[indexPath.row] {
                    let accessoryImage = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
                    accessoryImage.tintColor = .systemGreen
                    cell.accessoryView = accessoryImage
                } else {
                    let accessoryImage = UIImageView(image: UIImage(systemName: "chevron.right"))
                    accessoryImage.tintColor = .lightGray
                    cell.accessoryView = accessoryImage
                }
                
                return cell
            }

    //MARK: - UITableViewDelegate

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            // Redirigir a la vista específica según la opción seleccionada
            let segueIdentifier = segueIdentifiers[indexPath.row]
            performSegue(withIdentifier: segueIdentifier, sender: nil)

            // Marcar la opción como completada
            completionStatus[indexPath.row] = true
            tableView.reloadRows(at: [indexPath], with: .automatic)
            updateAcceptButtonState()
        }
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showNextView", sender: nil)
    }
    // MARK: - Actions

    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        if completionStatus.contains(false) {
                let alert = UIAlertController(
                    title: "Proceso Incompleto",
                    message: "Debes completar todas las opciones antes de continuar.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(
                    title: "Confirmación",
                    message: "Has completado el proceso de verificación.",
                    preferredStyle: .alert
                )
                
                // Agregar acción para navegar a otra vista después de la confirmación
                alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: { _ in
                    // Realizar navegación a la nueva vista
                    self.performSegue(withIdentifier: "showNextView", sender: nil)
                }))
                
                present(alert, animated: true, completion: nil)
            }
        }

    // MARK: - Helpers

    func updateAcceptButtonState() {
        // Habilitar o deshabilitar el botón Aceptar según el estado de las opciones
        acceptButton.isEnabled = !completionStatus.contains(false)
        acceptButton.backgroundColor = acceptButton.isEnabled ? UIColor.systemGreen : UIColor.lightGray
    }
    
}
