//
//  ViewController.swift
//  PaceCalc
//
//  Created by Jonathan Taylor on 2020-05-18.
//  Copyright © 2020 Jonathan Taylor. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController, UITextFieldDelegate {

    // Initializing Text Fields
    @IBOutlet weak var timeHr: UITextField!
    @IBOutlet weak var timeMin: UITextField!
    @IBOutlet weak var timeSec: UITextField!
    @IBOutlet weak var dist: UITextField!
    @IBOutlet weak var paceMin: UITextField!
    @IBOutlet weak var paceSec: UITextField!
    
    @IBOutlet weak var error: UILabel!
    
    @IBOutlet weak var distButton: UIButton!
    @IBOutlet weak var paceButton: UIButton!
    
    var varCount = 0
    var timeFull = false
    var distFull = false
    var paceFull = false
    var totalTime = 0.0
    var totalDistance = 0.0
    var totalPace = 0.0
    
    var distKm = true
    var paceKm = true
    
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
        timeHr.delegate = self
        timeMin.delegate = self
        timeSec.delegate = self
        paceMin.delegate = self
        paceSec.delegate = self
        
    }
    
    @IBAction func distPressed(_ sender: Any) {
        view.endEditing(true)
        
        if distButton.currentTitle == "Kilometers" {
            distButton.setTitle("Miles", for: [.normal])
            distKm = false
        }
        else {
            distButton.setTitle("Kilometers", for: [.normal])
            distKm = true
        }
    }
    
    @IBAction func pacePressed(_ sender: Any) {
        view.endEditing(true)
        
        if paceButton.currentTitle == "per Km" {
            paceButton.setTitle("per Mi", for: [.normal])
            paceKm = false
        }
        else {
            paceButton.setTitle("per Km", for : [.normal])
            paceKm = true
        }
    }
    
    private func ConvertPace(val: Double) {
        var paceDec = val
        
        if !paceKm {
            // Converting min/km to min/mile
            paceDec = paceDec * 1.609344
        }
        
        var minInt = Int(paceDec)
        let minDec = Double(Int(paceDec))
        let secDec = paceDec - minDec
        var secInt = Int(round(secDec * 60))
              
        if secInt >= 60 {
            minInt = minInt + 1
            secInt = 0
        }
              
        paceMin.text = String(minInt)
        paceSec.text = String(secInt)
    }
    
    @IBAction func calcPressed(_ sender: Any) {
        view.endEditing(true)
        
        timeFull = false
        distFull = false
        paceFull = false
        error.text = ""
        varCount = 0
        
        // setting text field values to doubles
        var timeHour = Double(timeHr.text!)
        var timeMinute = Double(timeMin.text!)
        var timeSecond = Double(timeSec.text!)
        
        let distance = Double(dist.text!)
        
        var paceMinute = Double(paceMin.text!)
        var paceSecond = Double(paceSec.text!)
        
        // Getting time values if they exist
        if timeHour != nil || timeMinute != nil || timeSecond != nil {
            varCount = varCount + 1
            timeFull = true
            
            if timeHour == nil {
                timeHour = 0
            }
            else {
                timeHour = timeHour! * 60
            }
            
            if timeMinute == nil {
                timeMinute = 0
            }
            
            if timeSecond == nil {
                timeSecond = 0
            }
            else {
                timeSecond = timeSecond! / 60
            }
            
            totalTime = timeHour! + timeMinute! + timeSecond!
        }
        
        // Getting distance values if they exist
        if distance != nil {
            varCount = varCount + 1
            distFull = true
            
            if distKm {
                totalDistance = distance!
            }
            else {
                // convert Miles to Kilometers
                totalDistance = distance! * 1.609344
            }
        }
        
        // Getting pace values if they exist
        if paceMinute != nil || paceSecond != nil {
            varCount = varCount + 1
            paceFull = true
            
            if paceMinute == nil {
                paceMinute = 0
            }
            
            if paceSecond == nil {
                paceSecond = 0
            }
            
            if  paceKm {
                let dec = paceSecond! / 60
                totalPace = (paceMinute! + dec)
            }
            else {
                let dec = paceSecond! / 60
                // convert min/mile to min/kilometer
                totalPace = (paceMinute! + dec) / 1.609344
            }
        }
        
        if varCount < 2 || varCount > 2 {
            error.text = "Please fill out only two of the three variables"
            return
        }
        
        if timeFull && distFull {
            totalPace = totalTime / totalDistance
            ConvertPace(val: totalPace)
        }
        else if timeFull && paceFull {
            totalDistance = totalTime / totalPace
            
            if distKm {
                dist.text = String(totalDistance)
            }
            else {
                // convert kilometers to miles
                totalDistance = totalDistance / 1.609344
                dist.text = String(totalDistance)
            }
        }
        else {
            totalTime = totalDistance * totalPace
            
            if totalTime >= 60 {
                timeHr.text = String(Int(totalTime/60))
                totalTime = (totalTime/60) - Double(Int(totalTime/60))
                totalTime = totalTime * 60
            }
            
            if Int(totalTime) >= 1 {
                timeMin.text = String(Int(totalTime))
                totalTime = totalTime - Double(Int(totalTime))
            }
            
            timeSec.text = String(Int(totalTime * 60))
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

