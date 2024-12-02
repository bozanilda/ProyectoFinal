//
//  ChatViewController.swift
//  parkallios
//
//  Created by Nilda Boza on 1/12/24.
//

import UIKit
import AVFoundation

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! // Tabla para mostrar los mensajes
    @IBOutlet weak var textField: UITextField! // Campo de texto para escribir mensajes
    @IBOutlet weak var sendButton: UIButton! // Botón para enviar mensajes
    @IBOutlet weak var micButton: UIButton! // Botón para grabar audio
    
    // MARK: - Variables
    var mensajes: [Mensaje] = [] // Array de mensajes (estructura definida más abajo)
    var grabadora: AVAudioRecorder? // Grabadora de audio
    var audioURL: URL? // URL para almacenar el audio grabado

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar la tabla
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "celda")
        
        // Configurar el campo de texto
        textField.delegate = self
        
        // Configurar el botón de grabación
        prepararGrabacion()
    }
    
    // MARK: - Funciones para la Tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mensajes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        let mensaje = mensajes[indexPath.row]
        
        // Mostrar el mensaje
        celda.textLabel?.text = mensaje.texto
        celda.textLabel?.textAlignment = mensaje.esEnviado ? .right : .left
        celda.textLabel?.textColor = mensaje.esEnviado ? .blue : .black
        
        return celda
    }
    
    // MARK: - Enviar Mensajes
    @IBAction func enviarMensaje(_ sender: UIButton) {
        guard let texto = textField.text, !texto.isEmpty else { return }
        
        // Agregar mensaje enviado
        let nuevoMensaje = Mensaje(texto: texto, esEnviado: true)
        mensajes.append(nuevoMensaje)
        textField.text = ""
        tableView.reloadData()
        
        // Simular respuesta
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let respuesta = Mensaje(texto: "Respuesta automática", esEnviado: false)
            self.mensajes.append(respuesta)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Grabación de Audio
    @IBAction func grabarAudio(_ sender: UIButton) {
        if grabadora == nil {
            comenzarGrabacion()
            micButton.setTitle("Detener", for: .normal)
        } else {
            detenerGrabacion()
            micButton.setTitle("Grabar", for: .normal)
        }
    }
    
    func prepararGrabacion() {
        let directorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        audioURL = directorio.appendingPathComponent("audio.m4a")
        
        let configuracion = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            grabadora = try AVAudioRecorder(url: audioURL!, settings: configuracion)
            grabadora?.prepareToRecord()
        } catch {
            print("Error al preparar la grabadora: \(error)")
        }
    }
    
    func comenzarGrabacion() {
        grabadora?.record()
    }
    
    func detenerGrabacion() {
        grabadora?.stop()
        grabadora = nil
        
        // Agregar el audio grabado como un mensaje
        if let audioPath = audioURL?.path {
            let mensajeAudio = Mensaje(texto: "Audio grabado: \(audioPath)", esEnviado: true)
            mensajes.append(mensajeAudio)
            tableView.reloadData()
        }
    }
}

// MARK: - Modelo de Mensaje
struct Mensaje {
    let texto: String
    let esEnviado: Bool // true si es enviado, false si es recibido
}
