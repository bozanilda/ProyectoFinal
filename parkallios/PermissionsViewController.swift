//
//  PermissionsViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 27/11/24.
//

import UIKit
import WebKit

class PermissionsViewController: UIViewController {
    @IBOutlet weak var webView1: WKWebView! // Conectar al Storyboard
    @IBOutlet weak var darPermisosButton: UIButton! // Botón para dar permisos
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Crear la URL a cargar en el WebView
               if let url = URL(string: "https://bozanilda.github.io/P-gina-legal-de-ParkAll/privacy-policy.html") {
                   let request = URLRequest(url: url)
                   webView1.load(request)
               }
               
               // Ocultar el botón al inicio
               darPermisosButton.isHidden = true
               
               // Iniciar temporizador para mostrar alerta después de 10 segundos
               DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                   self.showPermissionAlert()
               }
           }
    
    
    
    @IBAction func cerrarWebViewButtonTapped(_ sender: UIButton) {
        webView1.isHidden = true // Ocultar WebView
    }
    
    // Mostrar alerta después de 10 segundos
        func showPermissionAlert() {
            let alert = UIAlertController(title: "Permisos", message: "Por favor, da clic en el botón 'Dar permisos' para continuar.", preferredStyle: .alert)
            
            // Acción para "Aceptar"
            let acceptAction = UIAlertAction(title: "Aceptar", style: .default) { _ in
                self.showButtonAndMessage()
            }

            // Acción para "Seguir leyendo"
            let continueReadingAction = UIAlertAction(title: "Seguir leyendo", style: .default) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    self.showPermissionAlert() // Volver a mostrar el mensaje después de 20 segundos
                }
            }

            alert.addAction(acceptAction)
            alert.addAction(continueReadingAction)

            self.present(alert, animated: true, completion: nil)
        }
        
        // Mostrar botón y mensaje al aceptar
        func showButtonAndMessage() {
            darPermisosButton.isHidden = false // Mostrar el botón "Dar permisos"
            let alert = UIAlertController(title: "Mensaje", message: "Haz clic en el botón 'Dar permisos' para continuar.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
