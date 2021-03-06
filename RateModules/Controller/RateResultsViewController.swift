//
//  RateResultsViewController.swift
//  RateModule1
//
//  Created by Adrian Tineo on 26.01.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RateResultsViewController: UIViewController {
    
    var rateCalculator: RateCalculator?
    var studentName: String?
    var modulePicked: Module?
    

    @IBOutlet weak var resultEmojiLabel: UILabel!
    @IBOutlet weak var rateAsPercentLabel: UILabel!
    @IBOutlet weak var designRatioLabel: UILabel!
    @IBOutlet weak var requirementsRatioLabel: UILabel!
    @IBOutlet weak var codeStructureRatioLabel: UILabel!
    @IBOutlet weak var cleanCodeRatioLabel: UILabel!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var modulePickedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var studentToPersist = StudentsGrades(studentName: "", moduleGraded: "", didPass: "", finalGrade: "")
        //hide back button
        navigationItem.hidesBackButton = true
        
        //module and name
        if let name = studentName, let module = modulePicked?.rawValue {
            studentNameLabel.text = "Student: \(name)"
            modulePickedLabel.text = "Module: \(module)"
            studentToPersist.studentName = name
            studentToPersist.moduleGraded = module
        }
        
        guard let rateCalculator = rateCalculator else { return }
        
        if rateCalculator.hasPassed {
            resultEmojiLabel.text = "🥳"
        } else {
            resultEmojiLabel.text = "😔"
        }

        rateAsPercentLabel.text = NSString.init(format: "%.2f", rateCalculator.rateAsPercent) as String + " %"
        if !rateCalculator.hasPassed {
            rateAsPercentLabel.textColor = .red
        }

        if rateCalculator.numberOfDesignQuestions > 0 {
            designRatioLabel.text = "Preguntas de diseño: \(rateCalculator.numberOfRightlyAnsweredDesignQuestions)/\(rateCalculator.numberOfDesignQuestions)"
        } else {
            designRatioLabel.isHidden = true
        }
        
        requirementsRatioLabel.text = "Preguntas de requisitos: \(rateCalculator.numberOfRightlyAnsweredRequirementQuestions)/\(rateCalculator.numberOfRequirementQuestions)"
        codeStructureRatioLabel.text = "Preguntas de estructura de código: \(rateCalculator.numberOfRightlyAnsweredCodeStructureQuestions)/\(rateCalculator.numberOfCodeStructureQuestions)"
        cleanCodeRatioLabel.text = "Preguntas de código limpio: \(rateCalculator.numberOfRightlyAnsweredCleanCodeQuestions)/\(rateCalculator.numberOfCleanCodeQuestions)"
        
        if let emoji = resultEmojiLabel.text {
            studentToPersist.didPass = emoji
            studentToPersist.finalGrade = String(rateCalculator.totalRatio*100)
        }
        persistStudent(studentToPersist)
    }
    
    func persistStudent(_ studentGrade: StudentsGrades) {
        var studentList: [StudentsGrades] = StudentsGrades.loadFromFile()
        studentList.append(studentGrade)
        print(studentList)
        StudentsGrades.saveToFile(grades: studentList)
    }
    
}
