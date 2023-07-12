//
//  ViewController.swift
//  Table-Mixer
//
//  Created by Артем Михайлов on 12.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var data: [(Int, Bool)] = []
    let cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = (1...30).map { ($0, false) }
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(tableView)
        title = "task 4"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(shuffleCells))
    }
    
    @objc func shuffleCells() {
        data.shuffle()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let (number, isChecked) = data[indexPath.row]
        cell.textLabel?.text = "\(number)"
        cell.accessoryType = isChecked ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var item = data[indexPath.row]
        item.1.toggle()
        data[indexPath.row] = item
        
        if item.1 {
            data.remove(at: indexPath.row)
            data.insert(item, at: 0)
            
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        } else {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
        }
    }
}
