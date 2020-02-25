//
//  LandingViewController.swift
//  RateModules
//
//  Created by ADMIN on 25/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var studentNameEntered: UITextField!
    @IBOutlet weak var modulePicker: UIPickerView!
    
    //MARK: IBActions
    @IBAction func beginButtonTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getStudentNameEntered(from: UITextField) -> String? {
        guard let studentName = from.text else { return nil }
        return studentName
    }
    
    
}
