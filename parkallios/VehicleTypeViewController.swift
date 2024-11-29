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
        
        // Íconos para cada tipo de vehículo
        let vehicleIcons = [
            "camion_icon",   // Nombre del archivo del ícono de camión
            "auto_icon",     // Nombre del archivo del ícono de auto
            "camioneta_icon",  // Nombre del archivo del ícono de camioneta
            "moto_icon", // Nombre del archivo del ícono de moto
            "taxi_icon"     // Nombre del archivo del ícono de taxi
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
            
            // Configurar el ícono de la celda
            let iconName = vehicleIcons[indexPath.row]
            cell.imageView?.image = UIImage(named: iconName)

            return cell
        }
    
    }
        
        

