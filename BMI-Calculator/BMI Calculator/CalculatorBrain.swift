//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by ntubic on 25.11.2022..
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    
    func getBMIValue() -> String {
        let bmiDecimal = String(format: "%.1f", bmi?.value ?? 0.0)
            return bmiDecimal
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
    
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height*height)
        
        if bmiValue < 18.5{
            bmi = BMI(value: bmiValue, advice: "Eat more snacks", color: .blue)
        } else if bmiValue < 24.9{
            bmi = BMI(value: bmiValue, advice: "Stay the course", color: .green)
        } else {
            bmi = BMI(value: bmiValue, advice: "Might want to cut down", color: .red)
        }
        
        
    }

}
