//
//  ViewController.swift
//  Final
//
//  Created by Jiaying Xie on 5/2/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let unit = ["Imperial Formula", "Metric Formula"]
    
    @IBOutlet weak var unitPicker: UIPickerView!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtHeightFeet: UITextField!
    @IBOutlet weak var txtHeightInch: UITextField!
    @IBOutlet weak var lblHeightInch: UILabel!
    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        unitPicker.delegate = self
        unitPicker.dataSource = self
        lblErrorMessage.text = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unit.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unit[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (unit[row] == "Imperial Formula") {
            txtWeight.placeholder = "weight in lbs"
            txtHeightFeet.placeholder = "height in feet"
            lblHeightInch.isHidden = false
            txtHeightInch.isHidden = false
        } else {
            txtWeight.placeholder = "weight in kg"
            txtHeightFeet.placeholder = "height in m"
            lblHeightInch.isHidden = true
            txtHeightInch.isHidden = true
        }
        txtWeight.text = ""
        txtHeightFeet.text = ""
        txtHeightInch.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowCharacters = CharacterSet(charactersIn: ".0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        return allowCharacters.isSuperset(of: characterSet)
    }

    @IBAction func calculateBMI(_ sender: Any) {
        if (txtHeightInch.isHidden == false) {
            guard let weight = txtWeight.text else {return}
            guard let heightFeet = txtHeightFeet.text else {return}
            guard let heightInch = txtHeightInch.text else {return}
            
            // validate the input
            if (weight == "") {
                lblErrorMessage.text = "Please enter weight."
                return
            }
            guard let weightDouble = Double(weight) else {
                lblErrorMessage.text = "Weight could only be decimal number."
                return
            }
            if (weightDouble <= 0) {
                lblErrorMessage.text = "Weight could only be positive number."
                return
            }
            if (heightFeet == "") {
                lblErrorMessage.text = "Please enter height in feet."
                return
            }
            guard let heightFeetDouble = Double(heightFeet) else {
                lblErrorMessage.text = "Height in feet could only be decimal number."
                return
            }
            if (heightFeetDouble <= 0) {
                lblErrorMessage.text = "Height in feet could only be positive number."
                return
            }
            if (heightInch == "") {
                lblErrorMessage.text = "Please enter height in inch."
                return
            }
            guard let heightInchDouble = Double(heightInch) else {
                lblErrorMessage.text = "Height in inch could only be decimal number."
                return
            }
            if (heightInchDouble <= 0) {
                lblErrorMessage.text = "Height in inch could only be positive number."
                return
            }
            
            let totalInches = heightFeetDouble * 12 + heightInchDouble
            let bmi = (weightDouble * 703) / (totalInches * totalInches)
            let bmiString = String(format: "%.2f", bmi)
            
            lblErrorMessage.text = ""
            
            if (bmi < 18.5) {
                lblBMI.text = "BMI: " + bmiString + " Underweight"
            } else if (bmi <= 24.9) {
                lblBMI.text = "BMI: " + bmiString + " Healthy weight"
            } else if (bmi <= 29.9) {
                lblBMI.text = "BMI: " + bmiString + " Overweight"
            } else {
                lblBMI.text = "BMI: " + bmiString + " Obese"
            }
        } else {
            guard let weight = txtWeight.text else {return}
            guard let height = txtHeightFeet.text else {return}
            
            // validation
            if (weight == "") {
                lblErrorMessage.text = "Please enter weight."
                return
            }
            guard let weightDouble = Double(weight) else {
                lblErrorMessage.text = "Weight could only be decimal number."
                return
            }
            if (weightDouble <= 0) {
                lblErrorMessage.text = "Weight could only be positive number."
                return
            }
            if (height == "") {
                lblErrorMessage.text = "Please enter height of feet."
                return
            }
            guard let heightDouble = Double(height) else {
                lblErrorMessage.text = "Height could only be decimal number."
                return
            }
            if (heightDouble <= 0) {
                lblErrorMessage.text = "Height could only be positive number."
                return
            }

            
            lblErrorMessage.text = ""
            
            let bmi = weightDouble / (heightDouble * heightDouble)
            let bmiString = String(format: "%.2f", bmi)
            lblBMI.text = "BMI: " + bmiString
            
            if (bmi < 18.5) {
                lblBMI.text = "BMI: " + bmiString + " Underweight"
            } else if (bmi <= 24.9) {
                lblBMI.text = "BMI: " + bmiString + " Healthy weight"
            } else if (bmi <= 29.9) {
                lblBMI.text = "BMI: " + bmiString + " Overweight"
            } else {
                lblBMI.text = "BMI: " + bmiString + " Obese"
            }
            
        }
        
    }
    
}

