//
//  ConvertViewController.swift
//  PaceCalc
//
//  Created by Jonathan Taylor on 2020-05-18.
//  Copyright © 2020 Jonathan Taylor. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController, UITextFieldDelegate {
    
    // Initalizing Text Fields
    @IBOutlet weak var paceMin_1: UITextField!
    @IBOutlet weak var paceSec_1: UITextField!
    @IBOutlet weak var paceMin_2: UITextField!
    @IBOutlet weak var paceSec_2: UITextField!
    @IBOutlet weak var dist_1: UITextField!
    @IBOutlet weak var dist2: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configTapGesture()
        configTextFields()
    }
    
    // Removing keyboard when outside test field is tapped
    private func configTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CalcViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func configTextFields() {
        paceMin_1.delegate = self
        paceSec_1.delegate = self
        paceMin_2.delegate = self
        paceSec_2.delegate = self
    }
    
    @IBAction func ConvertOnePressed(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func ConvertTwoPressed(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func CalcPressed(_ sender: Any) {
        view.endEditing(true)
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

