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
    
    override func viewDidLoad() {
           super.viewDidLoad()

           // Crear la URL a cargar
           if let url = URL(string: "https://bozanilda.github.io/P-gina-legal-de-ParkAll/privacy-policy.html") {
               // Crear la solicitud de la URL
               let request = URLRequest(url: url)
               
               // Cargar la solicitud en el WKWebView
               webView1.load(request)
           }
       }
    
    @IBAction func darPermisosButtonTapped(_ sender: UIButton) {
        // URL de la política de privacidad
        guard let url = URL(string: "https://bozanilda.github.io/P-gina-legal-de-ParkAll") else { return }
        
        let request = URLRequest(url: url)
        webView1.load(request)
        webView1.isHidden = false // Mostrar WebView al cargar contenido
    }
    
    @IBAction func cerrarWebViewButtonTapped(_ sender: UIButton) {
        webView1.isHidden = true // Ocultar WebView
    }}
