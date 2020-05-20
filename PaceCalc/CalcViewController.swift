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
    }
    
    @IBAction func pacePressed(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calcPressed(_ sender: Any) {
        view.endEditing(true)
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

