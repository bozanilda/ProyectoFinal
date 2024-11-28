//
//  PermissionsViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 27/11/24.
//

import UIKit
import WebKit

class PermissionsViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView! // Conectar al Storyboard

    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configuración inicial
            webView.isHidden = true // Ocultar WebView inicialmente
        }
        
        @IBAction func darPermisosButtonTapped(_ sender: UIButton) {
            // URL de la política de privacidad
            guard let url = URL(string: "https://bozanilda.github.io/P-gina-legal-de-ParkAll/privacy-policy.html") else { return }
            
            let request = URLRequest(url: url)
            webView.load(request)
            webView.isHidden = false // Mostrar WebView al cargar contenido
        }
        
        @IBAction func cerrarWebViewButtonTapped(_ sender: UIButton) {
            webView.isHidden = true // Ocultar WebView
        }
    }
