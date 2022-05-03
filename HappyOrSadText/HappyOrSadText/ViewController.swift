//
//  ViewController.swift
//  HappyOrSadText
//
//  Created by Jiaying Xie on 4/17/22.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var txtInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func analyzeTextAction(_ sender: Any) {
        guard let text = txtInput.text else {return}
        
        let model = HappyOrSad()
        let prediction = try! model.prediction(text: text).label
        lblResult.text = prediction
    }
    
}

