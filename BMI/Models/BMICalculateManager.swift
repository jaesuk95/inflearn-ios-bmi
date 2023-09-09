//
//  BMICalculateManager.swift
//  BMI
//
//  Created by Jaesuk Lee on 2023/09/09.
//

import UIKit

struct BMICalculateManager {
    
    // save bmi value here
    var bmi: Double?
    
//    var bmiNumber: Double?
//    var adviceString: String?
//    var bmiColour: UIColor?
    
    // BMI calculation method
//    func calculateBmi(height: String, weight: String) -> Double {
    // mutating 속성을 수정하기 때문에 mutate 를 추가한다
    mutating func calculateBmi(height: String, weight: String) {
        
        guard let h = Double(height), let w = Double(weight) else {
            bmi = 0.0
            return
        }
        
        var bmiResult = w / (h * h) * 10000
        print("BMI 결과값 (반올림 이전): \(bmiResult)")
        bmiResult = round(bmiResult * 10) / 10
        print("BMI 결과값 (반올림 이후): \(bmiResult)")
        
        bmi = bmiResult
//        return bmi
    }
    
    func getBMIResult() -> Double {
        // ?? 0.0 기본 값 설정
        print("getBMIResult")
        return bmi ?? 0.0
    }
    
    // 색깔 얻는 메서드
    func getBackgroundColour() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    // 문자열 얻는 메서드
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "표준"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
    
}
