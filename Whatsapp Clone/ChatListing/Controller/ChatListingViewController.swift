//
//  ViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 23/02/22.
//

import UIKit
import Foundation

class ChatListingViewController: UIViewController {

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
    
    @IBOutlet var tableView: UITableView?
    
    private var currentChatIndex: Int
    private var allChats: [ChatListingStructure]
    
    required init?(coder: NSCoder) {
        currentChatIndex = 0
        allChats = API.instance.getChatListing()
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Chats"
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        tableView?.rowHeight = CGFloat(CellConstants.defaultCellHeight);
        
        //To hide the initial search bar in the chat
        tableView?.contentOffset = CGPoint(x: 0, y: tableView!.rowHeight)
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - View Controller Extension

extension ChatListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChats.count < 0 ? CellConstants.cells.count : allChats.count + CellConstants.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cells[indexPath.row].cellIdentifier, for: indexPath) as? SearchBarTableViewCell
            return cell ?? UITableViewCell()
        }
        
        if (indexPath.row < CellConstants.cells.count) {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cells[indexPath.row].cellIdentifier, for: indexPath) as? DefaultCell
            return cell ?? UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConstants.cellIdentifier, for: indexPath) as? DefaultCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        //The first two cells are different
        let row = indexPath.row - CellConstants.cells.count
        
        //Applying the data of the user to the chat
        cell?.profilePic.image = (allChats[row].isGroup ? ChatDefaults.groupProfilePic : ChatDefaults.userProfilePic)
        cell?.profilePic.makeRounded()
        cell?.name.text = allChats[row].name
        cell?.time.text = allChats[row].time
        cell?.lastMessage.text = allChats[row].lastMessage
        
        //Downloading the image
        /*if let url = allChats[row].profilePic {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.profilePic.image = UIImage(data: data)
                    }
                }
            }
        }*/
        return cell ?? UITableViewCell()
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
        
        let index = indexPath.row - CellConstants.cells.count
        
        let vc = storyboard?.instantiateViewController(identifier: "ChatViewController", creator: {coder -> ChatMessageViewController? in ChatMessageViewController(coder: coder, chatDetails: self.allChats[index], chatIndex: index)})
        
        guard let vc = vc else {
            fatalError("Can not instantiate the Message View Controller")
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
