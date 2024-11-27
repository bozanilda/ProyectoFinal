//
//  PrivacyPolicyViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 26/11/24.
//

import UIKit
import WebKit


class PrivacyPolicyViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // URL de la política de privacidad
        if let url = URL(string: "https://bozanilda.github.io/privacy-policy/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

