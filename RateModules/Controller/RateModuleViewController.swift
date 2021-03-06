//
//  RateModuleViewController.swift
//  RateModule1
//
//  Created by Adrian Tineo on 26.01.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RateModuleViewController: UITableViewController {
    
    var state = State(module: Module.module3B)
    var studentName: String?
    var modulePicked: Module?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name =  studentName, let module = modulePicked?.rawValue {
            navigationItem.title = "\(name) - \(module)"
        } else {
            navigationItem.title = "Module evaluation"
        }
    }
    
    private func update(selectedQuestion: Question, with value: Bool) {
        var index = state.designQuestions?.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            state.designQuestions![index].isPassed = value
            return
        }
        
        index = state.requirementsQuestions.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            state.requirementsQuestions[index].isPassed = value
            return
        }
        
        index = state.codeStructureQuestions.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            state.codeStructureQuestions[index].isPassed = value
            return
        }
        
        index = state.cleanCodeQuestions.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            state.cleanCodeQuestions[index].isPassed = value
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRateResults", let destination = segue.destination as? RateResultsViewController {
            destination.studentName = studentName
            destination.modulePicked = modulePicked
            destination.rateCalculator = RateCalculator(
                numberOfDesignQuestions: state.hasDesignSection ? state.designQuestions!.count : 0,
                numberOfRightlyAnsweredDesignQuestions: state.hasDesignSection ? state.designQuestions!.filter { $0.isPassed }.count : 0,
                numberOfRequirementQuestions: state.requirementsQuestions.count,
                numberOfRightlyAnsweredRequirementQuestions: state.requirementsQuestions.filter { $0.isPassed }.count,
                numberOfCodeStructureQuestions: state.codeStructureQuestions.count,
                numberOfRightlyAnsweredCodeStructureQuestions: state.codeStructureQuestions.filter { $0.isPassed }.count,
                numberOfCleanCodeQuestions: state.cleanCodeQuestions.count,
                numberOfRightlyAnsweredCleanCodeQuestions: state.cleanCodeQuestions.filter { $0.isPassed }.count)
        }
    }
}

// MARK: data source

extension RateModuleViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return state.hasDesignSection ? 4 : 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return state.hasDesignSection ? state.designQuestions!.count : state.requirementsQuestions.count
        case 1:
            return state.hasDesignSection ? state.requirementsQuestions.count : state.codeStructureQuestions.count
        case 2:
            return state.hasDesignSection ? state.codeStructureQuestions.count : state.cleanCodeQuestions.count
        case 3:
            return state.hasDesignSection ? state.cleanCodeQuestions.count : 0
        default:
            fatalError("Unexpected section")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
        cell.delegate = self
        
        let question: Question?
        switch section {
        case 0:
            if state.hasDesignSection {
                question = state.designQuestions![indexPath.row]
            } else {
                question = state.requirementsQuestions[indexPath.row]
            }
        case 1:
            if state.hasDesignSection {
                question = state.requirementsQuestions[indexPath.row]
            } else {
                question = state.codeStructureQuestions[indexPath.row]
            }
        case 2:
            if state.hasDesignSection {
                question = state.codeStructureQuestions[indexPath.row]
            } else {
                question = state.cleanCodeQuestions[indexPath.row]
            }
        case 3:
            if state.hasDesignSection {
                question = state.cleanCodeQuestions[indexPath.row]
            } else {
                question = nil
            }
        default:
            question = nil
        }
        
        if let question = question {
            let questionNumberInSection: String
            switch indexPath.section {
            case 0:
                questionNumberInSection = String("\(indexPath.row + 1)/\(state.designQuestions!.count)")
            case 1:
                questionNumberInSection = String("\(indexPath.row + 1)/\(state.requirementsQuestions.count)")
            case 2:
                questionNumberInSection = String("\(indexPath.row + 1)/\(state.codeStructureQuestions.count)")
            case 3:
                questionNumberInSection = String("\(indexPath.row + 1)/\(state.cleanCodeQuestions.count)")
            default:
                fatalError("Section doesn't exist")
            }
            cell.configure(with: question, at: questionNumberInSection)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "RateModuleSectionHeader")!
        switch section {
        case 0:
            header.textLabel?.text = state.hasDesignSection ? "Diseño (\(String(state.designQuestions!.count)))" : "Requisitos (\(String(state.requirementsQuestions.count)))"
        case 1:
            header.textLabel?.text = state.hasDesignSection ? "Requisitos (\(String(state.requirementsQuestions.count)))" : "Estructura de código (\(String(state.codeStructureQuestions.count)))"
        case 2:
            header.textLabel?.text = state.hasDesignSection ? "Estructura de código (\(String(state.codeStructureQuestions.count)))": "Código limpio (\(String(state.cleanCodeQuestions.count)))"
        case 3:
            header.textLabel?.text = state.hasDesignSection ? "Código limpio (\(String(state.cleanCodeQuestions.count)))" : ""
        default:
            fatalError("Unexpected section")
        }
        return header
    }
}

extension RateModuleViewController: QuestionTableViewCellDelegate {
    func didToggleSwitch(for question: Question, value: Bool) {
        update(selectedQuestion: question, with: value)
        tableView.reloadData()
    }
}

