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

        // Configurar el accesorio con flecha
        if completionStatus[indexPath.row] {
            // Si está completado, mostrar un check con flecha
            let accessoryImage = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
            accessoryImage.tintColor = .systemGreen
            cell.accessoryView = accessoryImage
        } else {
            // Si no está completado, solo flecha
            let accessoryImage = UIImageView(image: UIImage(systemName: "chevron.right"))
            accessoryImage.tintColor = .lightGray
            cell.accessoryView = accessoryImage
        }
        
        return cell
    }
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Simular completar la opción seleccionada
        completionStatus[indexPath.row] = true
        tableView.reloadRows(at: [indexPath], with: .automatic)
        updateAcceptButtonState()
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
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
