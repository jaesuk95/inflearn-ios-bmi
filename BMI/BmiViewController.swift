//
//  BmitViewController.swift
//  BMI
//
//  Created by Jaesuk Lee on 2023/09/03.
//

import UIKit

class BmiViewController: UIViewController {

    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviseLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 데이터를 전달 받을 때 '?' optional 추가
    var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeUI()
    }
    
    
    func makeUI() {
        
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        
        guard let bmi = bmi else {return}
        bmiNumberLabel.text = String(bmi)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
