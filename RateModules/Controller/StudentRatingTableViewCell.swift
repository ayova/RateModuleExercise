//
//  StudentRatingTableViewCell.swift
//  RateModules
//
//  Created by ADMIN on 01/03/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class StudentRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var moduleGraded: UILabel!
    @IBOutlet weak var didPassModule: UILabel!
    @IBOutlet weak var finalGrade: UILabel!
    
    func configureStudentRatingCell(studentName: String, moduleGraded: String, didPass: String, finalGrade: String){
        self.studentName.text = studentName
        self.moduleGraded.text = moduleGraded
        self.didPassModule.text = didPass
        self.finalGrade.text = finalGrade
    }

}
