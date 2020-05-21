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
    @IBOutlet weak var error: UILabel!
    
    var distIsKm = true
    var paceIsKm = true
    
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
    }
    
    private func ConvertPace(min:Double, sec: Double) {
        var paceDec:Double
        
        if paceIsKm {
            let dec = sec / 60
            paceDec = (min + dec) * 1.609344
        }
        else {
            let dec = sec / 60
            paceDec = (min + dec) / 1.609344
        }
        
        var minInt = Int(paceDec)
        let minDec = Double(Int(paceDec))
        let secDec = paceDec - minDec
        var secInt = Int(round(secDec * 60))
              
        if secInt >= 60 {
            minInt = minInt + 1
            secInt = 0
        }
              
        paceMin_2.text = String(minInt)
        paceSec_2.text = String(secInt)
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
        
        if paceIsKm {
            paceIsKm = false
            paceLabel_1.text = "per Mile"
            paceLabel_2.text = "per Kilometer"
        }
        else {
            paceIsKm = true
            paceLabel_1.text = "per Kilometer"
            paceLabel_2.text = "per Mile"
        }
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
        
        error.text = ""
        
        // Converting Pace
        var min = Double(paceMin_1.text!)
        var sec = Double(paceSec_1.text!)
        
        if min == nil {
            min = 0
        }
        
        if sec == nil {
            sec = 0
        }
        
        if sec! >= 60 {
            error.text = "Seconds value is too large"
            return
        }
        
        ConvertPace(min: min!, sec: sec!)
        
        // Converting Distance
        let val = Double(dist_1.text!)
        if val == nil {
            dist_2.text = ConvertDist(val: 0)
        }
        else {
            dist_2.text = ConvertDist(val: val!)
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

