//
//  StudentsGrades.swift
//  RateModules
//
//  Created by ADMIN on 01/03/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

struct StudentsGrades {
    var studentName: String
    var moduleGraded: String
    var didPass: String
    var finalGrade: String
}

extension StudentsGrades: Codable {
    
    static let archiveURL = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!.appendingPathComponent("Documents").appendingPathExtension("plist")
    
    static func saveToFile(grades: [StudentsGrades]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedGrades = try? propertyListEncoder.encode(grades)
        
        try? encodedGrades?.write(to: StudentsGrades.archiveURL, options: .noFileProtection)
        
    }
    
    static func loadFromFile() -> [StudentsGrades] {
        let propertyListDecoder = PropertyListDecoder()
        
        var gradesList: [StudentsGrades] = []
        
        if let retrievedRates = try? Data(contentsOf: StudentsGrades.archiveURL),
            let decodedRates = try? propertyListDecoder.decode(Array<StudentsGrades>.self, from: retrievedRates){
            
            gradesList.append(contentsOf: decodedRates.shuffled())
            
            return gradesList
        }
        return gradesList
    }
}
