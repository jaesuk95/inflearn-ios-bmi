//
//  ViewController.swift
//  BMI
//
//  Created by Jaesuk Lee on 2023/09/03.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    
//    var bmi: Double?
    var bmiNumber: Double?
    var adviceString: String?
    var bmiColour: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        makeUI()
    }

    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해주세요"
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        weightTextField.placeholder = "kg 단위로 입력해주세요"
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        guard let height = heightTextField.text,
              let weight = weightTextField.text
        else {return}
        
        bmiNumber = calculateBmi(height: height, weight: weight)
        bmiColour = getBackgroundColour()
        adviceString = getBMIAdviceString()
    
    }
    
    // 다음 화면으로 넘어가는 것을 허락할지 말지 (만약 다음 페이지가 당연하다면 shouldPerform.. 할 필요가 없다)
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        mainLabel.textColor = UIColor.blue
        return true
    }

    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // segue id = "toBMIVC"
        if segue.identifier == "toBMIVC" {
            let bmiVC = segue.destination as! BmiViewController
            
            // 계산된 결과값을 다음 화면으로 전달
            bmiVC.bmiNumber = self.bmiNumber
            bmiVC.bmiColour = self.bmiColour
            bmiVC.adviceString = self.adviceString
        }
        
        // 다음 화면으로 가기전에 텍스트필드 비우기 (reset the text field)
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    
    // BMI calculation method
    func calculateBmi(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else {return 0.0}
        var bmi = w / (h * h) * 10000
        print("BMI 결과값 (반올림 이전): \(bmi)")
        bmi = round(bmi * 10) / 10
        print("BMI 결과값 (반올림 이후): \(bmi)")
        return bmi
    }
    
    // 색깔 얻는 메서드
    func getBackgroundColour() -> UIColor {
        guard let bmi = bmiNumber else { return UIColor.black }
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
        guard let bmi = bmiNumber else { return "" }
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

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        if textField == heightTextField {
//
//        }
        
        if Int(string) != nil || string == "" {
            return true // 글자 입력을 허용
        }
        
        return false // 글자입력 허용하지 않음
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // 두번째 텍스트필드로 넘어가기
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    // 키보드 내리겠다
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}
