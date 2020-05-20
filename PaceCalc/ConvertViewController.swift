//
//  ConvertViewController.swift
//  PaceCalc
//
//  Created by Jonathan Taylor on 2020-05-18.
//  Copyright © 2020 Jonathan Taylor. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController, UITextFieldDelegate {
    
    // Initializing Text Fields
    @IBOutlet weak var paceMin_1: UITextField!
    @IBOutlet weak var paceSec_1: UITextField!
    @IBOutlet weak var paceMin_2: UITextField!
    @IBOutlet weak var paceSec_2: UITextField!
    @IBOutlet weak var dist_1: UITextField!
    @IBOutlet weak var dist_2: UITextField!
    
    // Initializing Labels
    @IBOutlet weak var paceLabel_1: UILabel!
    @IBOutlet weak var paceLabel_2: UILabel!
    @IBOutlet weak var distLabel_1: UILabel!
    @IBOutlet weak var distLabel_2: UILabel!
    
    var distIsKm = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigTapGesture()
        ConfigTextFields()
    }
    
    // Removing keyboard when outside test field is tapped
    private func ConfigTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CalcViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func ConfigTextFields() {
        paceMin_1.delegate = self
        paceSec_1.delegate = self
        paceMin_2.delegate = self
        paceSec_2.delegate = self
//        dist_1.delegate = self
    }
    
    private func ConvertDist(val: Double) -> String {
        if distIsKm {
            return String(val / 1.609344)
        }
        else {
            return String(val * 1.609344)
        }
    }
    
    @IBAction func ConvertOnePressed(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func ConvertTwoPressed(_ sender: Any) {
        view.endEditing(true)
        
        if distIsKm {
            distIsKm = false
            distLabel_1.text = "Miles"
            distLabel_2.text = "Kilometers"
        }
        else {
            distIsKm = true
            distLabel_1.text = "Kilometers"
            distLabel_2.text = "Miles"
        }
            
    }
    
    @IBAction func CalcPressed(_ sender: Any) {
        view.endEditing(true)
        
        // Converting Distance
        let tmp = Double(dist_1.text!)
        if tmp == nil {
            dist_2.text = ConvertDist(val: 0)
        }
        else {
            dist_2.text = ConvertDist(val: tmp!)
        }
    }
    
    // Setting test field character limit to two
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 2
    }
    

}

