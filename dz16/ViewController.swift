//
//  ViewController.swift
//  dz16
//
//  Created by Павел Платов on 11.01.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let image = UIImage(named: "pepe") {
            let imageName = saveImage(image: image)
            UserDefaults.standard.set(imageName, forKey: "image")
        }
        
        
        
        //        let text = textField.text
        //        textField.text = nil
        //        UserDefaults.standard.set(text, forKey: "text")
    }
    @IBAction func loadButtonPressed(_ sender: Any) {
        guard let imageName = UserDefaults.standard.value(forKey: "image") as? String else {return}
        if let image = loadImage(fileName: imageName) {
            imageView.image = image
        }
        
        
        
        //        guard let text = UserDefaults.standard.value(forKey: "text") as? String else { return }
        //     label.text = text
    }
    
    func saveImage(image: UIImage) -> String? {
        guard let documetnsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = UUID().uuidString
        let filerURL = documetnsDirectory.appendingPathComponent(fileName)
        guard let data = image.pngData() else { return nil }
        
        if FileManager.default.fileExists(atPath: filerURL.path) {
            do {
                try FileManager.default.removeItem(atPath: filerURL.path)
                print("Removed old image")
                
            } catch let error {
                print("couldn't remove file at path", error)
            }
        }
        do {
            try data.write(to: filerURL)
            return fileName
            
        } catch let error {
            print("error savimg file with error", error)
            return nil
        }
        
    }
    func loadImage(fileName: String) -> UIImage? {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageUrl = documentsDirectory.appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    
}

extension ViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

