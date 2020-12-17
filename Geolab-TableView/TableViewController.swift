//
//  TableViewController.swift
//  Geolab-TableView
//
//  Created by Nikoloz Tatunashvili on 17.12.20.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableDataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Table View"
        let rightItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(rightButtonAction))
        navigationItem.setRightBarButton(rightItem, animated: true)
        
        tableDataSource = (0...( (10...100).randomElement() ?? 50) ).map { "cell \($0)" }
    }


    @objc func rightButtonAction(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = tableView.isEditing ? "Done" : "Edit"
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = tableDataSource[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempData = tableDataSource.remove(at: sourceIndexPath.row)
        tableDataSource.insert(tempData, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        
        let action1 = UIContextualAction(style: .normal, title: "Remove") { (action, view, completion) in
            view.backgroundColor = .red
            self.removeCell(at: indexPath)

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completion(true)
            }

        }
        
        action1.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [action1])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in

        }

        return UISwipeActionsConfiguration(actions: [editAction])
    }

    func removeCell(at indexPath: IndexPath) {
        tableDataSource.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

