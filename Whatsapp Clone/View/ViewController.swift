//
//  ViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 23/02/22.
//

import UIKit

class ViewController: UIViewController {

    private enum Constants {
        static let cellIdentifier = "Cell"
    }
    
    @IBOutlet var tableView: UITableView!
    
    private var currentChatIndex = 0
    private var currentChatData: ChatData?
    private var allChats = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        allChats = API.instance.getChats()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func showData() {
        for chat in allChats {
            currentChatData = chat.tableRepresentation
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*guard let chatData = currentChatData else {
            return 0
        }*/
        //return chatData.count
        return allChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! Cell
        
        let row = indexPath.row
        cell.name!.text = allChats[row].name
        cell.time!.text = allChats[row].time.formatted()
        cell.lastMessage!.text = allChats[row].lastMessage
    
        return cell
    }
}
