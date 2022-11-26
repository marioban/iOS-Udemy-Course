//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.0
    var split: String = ""
    var tipString: String = ""
    var stringPay: String = ""
    

    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        // disselect all buttons
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //selected button
        sender.isSelected = true
        
        //getting the button title
        tipString = sender.currentTitle!
        let buttonTitle = tipString
        
        
        //getting rid of %
        let noPercent = String(buttonTitle.dropLast())
        
        //casting string into double
        let buttonNumber = Double(noPercent)!
        
        tip = buttonNumber / 100
        
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        if  sender.value <= 12 {
            split = String(Int(sender.value))
            splitNumberLabel.text = split
        }
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let split = Double(splitNumberLabel.text!) ?? 0.0
        let bill = Double(billTextField.text!) ?? 0.0
        print(tip)
        print(split)
        print(bill)
        let toPay = (Double(bill) * (1+tip)) / Double(split)
        stringPay = String(format: "%.2f", toPay)
        
        print(stringPay)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.settings = "Split between \(split) people, with \(tipString) tip"
            destinationVC.total = stringPay
        }
    }
    
}

