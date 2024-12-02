//
//  BasicInfoViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 2/12/24.
//

import UIKit
import FirebaseStorage

class BasicInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Variables
    var storageRef: StorageReference!
    var isPhotoAdded = false
    var isFormValid: Bool {
        return isPhotoAdded &&
        !(nameTextField.text?.isEmpty ?? true) &&
        !(lastNameTextField.text?.isEmpty ?? true) &&
        !(emailTextField.text?.isEmpty ?? true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializar Firebase Storage
        storageRef = Storage.storage().reference()
        
        // Configurar UI
        nextButton.isHidden = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        
        // Configurar el DatePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date() // No permitir fechas futuras
        
        // Configurar los campos de texto
        [nameTextField, lastNameTextField, emailTextField].forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    // MARK: - IBActions
    @IBAction func addPhotoTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard isFormValid else {
            mostrarAlerta(titulo: "Error", mensaje: "Por favor, completa todos los campos y sube una foto.")
            return
        }
        
        // Obtener datos del formulario
        let nombre = nameTextField.text ?? ""
        let apellido = lastNameTextField.text ?? ""
        let correo = emailTextField.text ?? ""
        let fechaNacimiento = formatDate(datePicker.date)
        
        // Mensaje de confirmación
        let mensaje = """
                Los datos ingresados son:
                - Nombre: \(nombre)
                - Apellido: \(apellido)
                - Fecha de Nacimiento: \(fechaNacimiento)
                - Correo: \(correo)
                """
        
        mostrarAlerta(titulo: "Confirmación", mensaje: mensaje) { [weak self] _ in
            self?.subirFotoYContinuar()
        }
    }
    
    // MARK: - Funciones Auxiliares
    func validateForm() {
        nextButton.isHidden = !isFormValid
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        validateForm()
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: completion))
        present(alert, animated: true, completion: nil)
    }
    
    func subirFotoYContinuar() {
        // Subir foto a Firebase Storage
        guard let imageData = profileImageView.image?.jpegData(compressionQuality: 0.8) else {
            mostrarAlerta(titulo: "Error", mensaje: "No se pudo procesar la imagen.")
            return
        }
        
        let uniqueID = UUID().uuidString
        let photoRef = storageRef.child("profile_photos/\(uniqueID).jpg")
        
        // Mostrar un indicador de carga (opcional)
        let loadingAlert = UIAlertController(title: "Subiendo Foto", message: "Por favor, espera...", preferredStyle: .alert)
        present(loadingAlert, animated: true, completion: nil)
        
        photoRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            // Dismiss indicador de carga
            loadingAlert.dismiss(animated: true, completion: nil)
            
            if let error = error {
                self?.mostrarAlerta(titulo: "Error", mensaje: "No se pudo subir la foto: \(error.localizedDescription)")
                return
            }
            
            // Obtener la URL de descarga
            photoRef.downloadURL { url, error in
                if let error = error {
                    self?.mostrarAlerta(titulo: "Error", mensaje: "No se pudo obtener la URL de la foto: \(error.localizedDescription)")
                    return
                }
                
                if let url = url {
                    print("Foto subida correctamente: \(url)")
                    // Mostrar mensaje de confirmación al usuario
                    self?.mostrarAlerta(titulo: "Éxito", mensaje: "La foto se subió correctamente.")
                }
            }
        }
    }
    
    func mostrarAlerta(titulo: String, mensaje: String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }}
