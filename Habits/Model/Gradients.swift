//
//  Gradients.swift
//  Habits
//
//  Created by Alexander Thompson on 12/8/21.
//

import UIKit
//create an enum here to be able to select which color grade yuou want

struct Gradients {

    let blueGradient = [
                        UIColor(red: 4/255.0, green: 187/255.0, blue: 255/255.0, alpha: 1.0).cgColor, UIColor(red: 80/255.0, green: 94/255.0, blue: 255/255.0, alpha: 1.0).cgColor]

let orangeGradient = [ UIColor(red: 255/255.0, green: 220/255.0, blue: 0/255.0, alpha: 1).cgColor, UIColor(red: 253/255.0, green: 94/255.0, blue: 0/255.0, alpha: 1).cgColor]

let pinkGradient = [ UIColor(red: 255/255.0, green: 159/255.0, blue: 140/255.0, alpha: 1).cgColor, UIColor(red: 253/255.0, green: 76/255.0, blue: 134/255.0, alpha: 1).cgColor]

let greenGradient = [ UIColor(red: 148/255.0, green: 251/255.0, blue: 171/255.0, alpha: 1).cgColor, UIColor(red: 31/255.0, green: 196/255.0, blue: 159/255.0, alpha: 1).cgColor]

    let purpleGradient = [ UIColor(red: 250/255.0, green: 125/255.0, blue: 255/255.0, alpha: 1).cgColor, UIColor(red: 176/255.0, green: 64/255.0, blue: 255/255.0, alpha: 1).cgColor]

}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}

