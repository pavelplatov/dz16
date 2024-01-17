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
//        if let image = UIImage(named: "pepe") {
//            let imageName = saveImage(image: image)
//            UserDefaults.standard.set(imageName, forKey: "image")
//        }
        let beer = Beer(name: "Baltika", price: 1)
        UserDefaults.standard.set(encodable: beer, forKey: "beer")
        
        
        
        //        let text = textField.text
        //        textField.text = nil
        //        UserDefaults.standard.set(text, forKey: "text")
    }
    @IBAction func loadButtonPressed(_ sender: Any) {
//        guard let imageName = UserDefaults.standard.value(forKey: "image") as? String else {return}
//        if let image = loadImage(fileName: imageName) {
//            imageView.image = image
//        }
//
        guard let beer = UserDefaults.standard.value(Beer.self, forKey: "beer") else { return }
        label.text = beer.name
        
        
        
        //        guard let text = UserDefaults.standard.value(forKey: "text") as? String else { return }
        //     label.text = text
    }
    
    @IBAction func customViewXibPress(_ sender: Any) {
        let customView = CustomClass.instanceFromNib()
        customView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 150)
        customView.confogure(text: "Изменил XIB")
        view.addSubview(customView)
    }
    @IBAction func imagePickerButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        var chosenImage = UIImage()
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        }
        imageView.image = chosenImage
        picker.dismiss(animated: true, completion: nil)
    }
}

