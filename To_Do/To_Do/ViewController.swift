//
//  ViewController.swift
//  To_Do
//
//  Created by Picsart Academy on 26.07.23.
//

import UIKit


class Tasks {
    var title: String = ""
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

final class ViewController: UIViewController {
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    private var toDoList = [Tasks]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoList = [Tasks(title: "Task1", isCompleted: true),
                    Tasks(title: "Task2", isCompleted: true),
                    Tasks(title: "Task3", isCompleted: false)]
        
        let nib = UINib(nibName: "ToDoTableViewCell", bundle: nil)
        toDoTableView.register(nib, forCellReuseIdentifier: "cell")
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        toDoTableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func onAdd(_ sender: UIButton) {
        if let enteredText = textField.text {
            let title = enteredText
            toDoList.append(Tasks(title: title, isCompleted: false))
            toDoTableView.reloadData()
            textField.text = ""
            textField.resignFirstResponder()
        }
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        
        let task = toDoList[indexPath.row]

        cell.titleLabel.text = task.title
        if task.isCompleted {
            cell.cellImage.image = UIImage(named: "done")
            } else {
                cell.cellImage.image = UIImage(named: "notDone.jpg")
            }
        
        return cell
    }
}

    
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = toDoList[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell {
            let actionTitle = task.isCompleted ? "Undone" : "Done"
            
            let action = UIContextualAction(style: .normal, title: actionTitle) { _, _, completionHandler in
                task.isCompleted = !task.isCompleted
                
                if task.isCompleted {
                    cell.cellImage.image = UIImage(named: "done")
                } else {
                    cell.cellImage.image = UIImage(named: "notDone.jpg")
                }
                
                completionHandler(true)
            }
            
            action.backgroundColor = task.isCompleted ? .orange : .green
            let swipeAction = UISwipeActionsConfiguration(actions: [action])
            return swipeAction
        }
        return nil
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _  in
            self?.toDoList.remove(at: indexPath.row)
            self?.toDoTableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        action.backgroundColor = .red
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
    }
    
}

