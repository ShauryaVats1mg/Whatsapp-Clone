//
//  ViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 23/02/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    private enum CellConstants {
        static let cellIdentifier = "Cell"
        static let cellHeight = 100
    }
    
    private enum ChatDefaults {
        static let userProfilePic = UIImage.init(systemName: "person")
        static let groupProfilePic = UIImage.init(systemName: "person.3")
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
        
        tableView.rowHeight = CGFloat(CellConstants.cellHeight);
    }
}

// MARK: - View Controller Extension

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChats.count<0 ? 0 : allChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cellIdentifier, for: indexPath) as! Cell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let row = indexPath.row
        
        cell.profilePic.image = allChats[row].profilePic == nil ? (allChats[row].isGroup ? ChatDefaults.groupProfilePic : ChatDefaults.userProfilePic) : allChats[row].profilePic
        cell.name!.text = allChats[row].name
        cell.time!.text = dateFormatter.string(from: allChats[row].time)
        cell.lastMessage!.text = allChats[row].lastMessage
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CellConstants.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController

        navigationController?.pushViewController(vc, animated: true)
        vc.title = allChats[indexPath.row].name
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
