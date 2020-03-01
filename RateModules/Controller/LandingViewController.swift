//
//  LandingViewController.swift
//  RateModules
//
//  Created by ADMIN on 25/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    //MARK: Variables
    var studentName: String?
    var modulePicked = Module.module2A
    var modules: [Module] = [.module2A,.module2B,.module3A,.module3B]
    
    //MARK: IBOutlets
    @IBOutlet weak var studentNameEntered: UITextField!
    @IBOutlet weak var modulePicker: UIPickerView!
    @IBOutlet weak var beginButtonOutlet: UIButton!
    
    //MARK: IBActions
    @IBAction func beginButtonTapped(_ sender: Any) {
        guard let studentName = getStudentNameEntered(from: studentNameEntered)  else {return}
        //        print("Name: \(studentName), module: \(modulePicked)") // placeholder
        //        performSegue(withIdentifier: "ShowRateModule", sender: (studentName,modulePicked))
        
    }
    
    @IBAction func endedEnteringName(_ sender: Any) {
        guard !studentNameEntered.text!.isEmpty else {
            beginButtonOutlet.isEnabled = false
            beginButtonOutlet.alpha = 0.5
            return
        }
        beginButtonOutlet.isEnabled = true
        beginButtonOutlet.alpha = 1
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates
        studentNameEntered.delegate = self
        modulePicker.delegate = self
        
        //begin button is initially grayed out
        beginButtonOutlet.isEnabled = false
        beginButtonOutlet.alpha = 0.5
        
    }
    
    //MARK: Input processing functions
    func getStudentNameEntered(from textField: UITextField) -> String? {
        guard let studentName = textField.text else { return nil }
        return studentName
    }
    
    func getModulePicked(from pickerView: UIPickerView) -> Module? {
        //        guard let modulePicked = pickerView.
        return modulePicked
    }
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowRateModule", let destination = segue.destination as? RateModuleViewController else { return }
        
        // set values to pass
        destination.studentName = getStudentNameEntered(from: studentNameEntered)
        destination.modulePicked = getModulePicked(from: modulePicker)
    }
    
    @IBAction func prepareForUnwindToMain(segue: UIStoryboardSegue) {
        studentNameEntered.text = ""
    }
}

//MARK: Picker delegate
extension LandingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modules.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modules[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        modulePicked = modules[row]
    }
}

//MARK: Textfield delegate
//(hide keyboard)
extension LandingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
