//
//  AdminRegisterViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 26/11/24.
//

import UIKit
import FirebaseAuth

class AdminRegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var adminCodeTextField: UITextField!
    let ALLOWED_EMAIL = "ParkAll@gmail.com"
        let ALLOWED_PASSWORD = "parkall"
        let ADMIN_CODE = 03032002
    @IBAction func registerAdminButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, email == ALLOWED_EMAIL, // Validar correo
                      let password = passwordTextField.text, password == ALLOWED_PASSWORD, // Validar contraseña
                      let confirmPassword = confirmPasswordTextField.text, password == confirmPassword, // Contraseñas deben coincidir
                      let adminCodeText = adminCodeTextField.text, // Texto ingresado
                      let adminCode = Int(adminCodeText), adminCode == ADMIN_CODE else { // Validar código de administrador
                    showAlert(message: "Datos incorrectos. Asegúrate de ingresar el correo, contraseña y código válidos.")
                    return
                }

                // Intentar registrar al administrador en Firebase
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        // Mostrar mensaje de error si no se pudo registrar
                        self.showAlert(message: "Error al registrar administrador: \(error.localizedDescription)")
                    } else {
                        // Mostrar mensaje de éxito si se registró correctamente
                        self.showAlert(message: "¡Administrador registrado exitosamente!")
                    }
                }
            }

            private func showAlert(message: String) {
                let alert = UIAlertController(title: "Mensaje", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
