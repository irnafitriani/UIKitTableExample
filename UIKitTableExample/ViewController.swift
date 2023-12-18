//
//  ViewController.swift
//  UIKitTableExample
//
//  Created by irna fitriani on 13/12/23.
//

import UIKit

import Foundation

struct Quote: Codable {
    let q: String
}

class TableViewController: UITableViewController {

    var quotes: [Quote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getQuotes()
    }
    
    func getQuotes() {
        Task {
            do {
                self.quotes = try await NetworkManager.shared.getQuote()
                self.tableView.reloadData()
            } catch {
                print("error")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let quote = quotes[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = quote.q
        return cell
    }
}
    

