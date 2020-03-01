//
//  StudentRatingsTableViewController.swift
//  RateModules
//
//  Created by ADMIN on 01/03/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class StudentRatingsTableViewController: UITableViewController {
    
    var studentsList = [StudentsGrades]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //retrieve data from file
        studentsList = StudentsGrades.loadFromFile()
        studentsList.sort(by: {$0.studentName < $1.studentName}) // reminder: sorting the list is key to avoid deletion errors
        //set edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "Editar"
        //display data in cells
        tableView.reloadData()
    }
    
    // MARK: - Edit button title
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if(self.isEditing){
            self.editButtonItem.title = "Hecho"
        }else{
            self.editButtonItem.title = "Editar"
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentGrades", for: indexPath) as! StudentRatingTableViewCell
        let student = studentsList[indexPath.row]

        cell.configureStudentRatingCell(studentName: student.studentName, moduleGraded: student.moduleGraded, didPass: student.didPass, finalGrade: student.finalGrade)
        
        return cell
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            removeStudent(at: indexPath.row)
            studentsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)})

        } 
    }
  
    func removeStudent(at: Int) {
        var list: [StudentsGrades] = StudentsGrades.loadFromFile()
        list.remove(at: at)
        StudentsGrades.saveToFile(grades: list)
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
