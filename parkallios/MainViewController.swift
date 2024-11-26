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

    @IBAction func iniciarSesionTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            mostrarAlerta(mensaje: "Por favor, completa los campos.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.mostrarAlerta(mensaje: "Error al iniciar sesión: \(error.localizedDescription)")
            } else {
                self.performSegue(withIdentifier: "segueToHome", sender: self)
            }
        }
    }

    func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}

