//
//  RentParking6ViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 1/12/24.
//

import UIKit

class RentParking6ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Variables
    let hours = Array(1...100) // Horas de 1 a 100
    var selectedHour: Int = 1
    let ratePerHour: [Double] = stride(from: 5.20, through: 50.00, by: 0.50).map { $0 } // Tarifas dinámicas: desde 4.00 hasta 50.00 con incrementos de 0.50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración inicial
        pickerView.delegate = self
        pickerView.dataSource = self
        updatePriceLabel()
    }
    
    // MARK: - UIPickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    // MARK: - UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(hours[row]) hora(s)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedHour = hours[row]
        updatePriceLabel()
    }
    
    // Actualizar etiqueta de precio
    func updatePriceLabel() {
        let totalCost = ratePerHour[selectedHour - 1] // Precio basado en la hora seleccionada
        priceLabel.text = "S/. \(String(format: "%.2f", totalCost)) por \(selectedHour) hora(s)"
    }
    
    // MARK: - IBActions
    @IBAction func payButtonTapped(_ sender: UIButton) {
        let totalCost = ratePerHour[selectedHour - 1]
        let alert = UIAlertController(title: "Total a Pagar", message: "El costo por \(selectedHour) hora(s) es S/. \(totalCost).", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Aceptar", style: .default) { _ in
            self.showPaymentOptions()
        }
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showPaymentOptions() {
        let paymentAlert = UIAlertController(title: "Método de Pago", message: "Seleccione un método de pago", preferredStyle: .alert)
        paymentAlert.addAction(UIAlertAction(title: "Yape", style: .default, handler: nil))
        paymentAlert.addAction(UIAlertAction(title: "Tarjeta", style: .default, handler: nil))
        present(paymentAlert, animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        let deleteAlert = UIAlertController(title: "Alquiler Eliminado", message: "Se eliminó el alquiler correctamente.", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(deleteAlert, animated: true, completion: nil)
    }
}
