//
//  CustomClass.swift
//  dz16
//
//  Created by Павел Платов on 16.01.2024.
//

import UIKit

class CustomClass: UIView {

    @IBOutlet var label: UILabel!
    static func instanceFromNib() -> CustomClass {
        return UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: nil, options: nil) [0] as!
        CustomClass
    }
    
    func confogure(text: String) {
        label.text = text
    }
    

}
