//
//  ViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 23/02/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    private struct CellData {
        var cellIdentifier: String
        var cellHeight: Int
    }
    
    private enum CellConstants {
        //Cell is of type (identifier, height)
        static let cells: [CellData] = [
            CellData(cellIdentifier: "SearchBarCell", cellHeight: 80),
            CellData(cellIdentifier: "NewGroupCell", cellHeight: 40),
            CellData(cellIdentifier: "ArchiveCell", cellHeight: 40)
        ]
        static let cellIdentifier = "Cell"
        static let defaultCellHeight = 80
    }
    
    private enum ChatDefaults {
        static let userProfilePic = UIImage.init(systemName: "person.fill")
        static let groupProfilePic = UIImage.init(systemName: "person.2.fill")
    }
    
    @IBOutlet var tableView: UITableView!
    
    private var currentChatIndex = 0
    private var allChats = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Chats"
        
        allChats = API.instance.getChats()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = CGFloat(CellConstants.defaultCellHeight);
        
        //To hide the initial search bar in the chat
        tableView.contentOffset = CGPoint(x: 0, y: tableView.rowHeight)
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - View Controller Extension

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChats.count < 0 ? CellConstants.cells.count : allChats.count + CellConstants.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cells[indexPath.row].cellIdentifier, for: indexPath) as! SearchBarTableViewCell
            return cell
        }
        
        if (indexPath.row < CellConstants.cells.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cells[indexPath.row].cellIdentifier, for: indexPath) as! Cell
            return cell
        }
        
        let cell: Cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cellIdentifier, for: indexPath) as! Cell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        //The first two cells are different
        let row = indexPath.row - CellConstants.cells.count
        
        //cell.profilePic.image = allChats[row].profilePic == nil ? ((allChats[row].isGroup ?? false) ? ChatDefaults.groupProfilePic : ChatDefaults.userProfilePic) : allChats[row].profilePic
        cell.profilePic.image = ((allChats[row].isGroup ?? false) ? ChatDefaults.groupProfilePic : ChatDefaults.userProfilePic)
        cell.profilePic.makeRounded()
        cell.name!.text = allChats[row].name
        cell.time!.text = allChats[row].time
        cell.lastMessage!.text = allChats[row].lastMessage
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row < CellConstants.cells.count) {
            return CGFloat(CellConstants.cells[indexPath.row].cellHeight);
        }
        
        return CGFloat(CellConstants.defaultCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row < CellConstants.cells.count) {
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController

        navigationController?.pushViewController(vc, animated: true)
        vc.title = allChats[indexPath.row - CellConstants.cells.count].name
    }
}
