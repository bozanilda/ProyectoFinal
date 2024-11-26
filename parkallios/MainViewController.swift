//
//  ViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 12/11/24.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Por favor completa todos los campos.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Error al iniciar sesión: \(error.localizedDescription)")
            } else {
                self.showAlert(message: "¡Inicio de sesión exitoso!")
            }
        }
    }

    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        // Navegar a la pantalla de "Crear Cuenta"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createAccountVC = storyboard.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        self.navigationController?.pushViewController(createAccountVC, animated: true)
    }

    @IBAction func registerAsAdminButtonTapped(_ sender: UIButton) {
        // Navegar a la pantalla de "Administrador"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let adminRegisterVC = storyboard.instantiateViewController(withIdentifier: "AdminRegisterViewController") as! AdminRegisterViewController
        self.navigationController?.pushViewController(adminRegisterVC, animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Mensaje", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
