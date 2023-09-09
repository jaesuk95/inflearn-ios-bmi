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

    

    var bmiManager = BMICalculateManager()
    
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
        print(#function)
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

    // 데이터 전달 (direct Segue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // segue id = "toBMIVC"
        if segue.identifier == "toBMIVC" {
            let bmiVC = segue.destination as! BmiViewController
            
            // 계산된 결과값을 다음 화면으로 전달
            bmiVC.bmi = bmiManager.getBMI(height: heightTextField.text!, weight: weightTextField.text!)

        }
        
        // 다음 화면으로 가기전에 텍스트필드 비우기 (reset the text field)
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

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






//    var bmi: Double?
//    var bmiNumber: Double?
//    var adviceString: String?
//    var bmiColour: UIColor?


//        guard let height = heightTextField.text,
//              let weight = weightTextField.text
//        else {return}
        
//        bmiManager.(height: height, weight: weight)

//            bmiVC.bmiNumber = bmiManager.getBMIResult()
//            bmiVC.bmiColour = bmiManager.getBackgroundColour()
//            bmiVC.adviceString = bmiManager.getBMIAdviceString()



//        if textField == heightTextField {
//
//        }
