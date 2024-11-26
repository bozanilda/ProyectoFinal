//
//  CreateAccountViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 26/11/24.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, password == confirmPassword else {
            showAlert(message: "Por favor verifica los campos.")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(message: "Error al crear cuenta: \(error.localizedDescription)")
            } else {
                self.showAlert(message: "¡Cuenta creada exitosamente!")
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Mensaje", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
