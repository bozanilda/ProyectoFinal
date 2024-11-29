//
//  VehicleTypeViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 28/11/24.
//

import UIKit

class VehicleTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    // Datos de los tipos de vehículos
    let vehicleTypes = [
        "Camión",
        "Auto",
        "Camioneta",
        "Moto",
        "Taxi"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configurar el TableView
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicleTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleCell", for: indexPath)
        
        // Configurar el texto de la celda
        cell.textLabel?.text = vehicleTypes[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .darkGray

        // Configurar el accesorio de la celda
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Mostrar una alerta con la selección
        let selectedVehicle = vehicleTypes[indexPath.row]
        let alert = UIAlertController(
            title: "Vehículo Seleccionado",
            message: "Has seleccionado: \(selectedVehicle)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
