//
//  DataManager.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 24/02/22.
//

import Foundation

class DataManager {
    private var chats = [Chat]()
    
    init() {
        chats.append(Chat(
            name: "Name 1", time: Date.distantPast, lastMessage: "Last 1"
        ))
        
        chats.append(Chat(
            name: "Name 2", time: Date.distantPast, lastMessage: "Last 2"
        ))
        
        chats.append(Chat(
            name: "Name 3", time: Date.distantPast, lastMessage: "Last 3"
        ))
        
        chats.append(Chat(
            name: "Name 4", time: Date.distantPast, lastMessage: "Last 4"
        ))
    }
    
    func getChats() -> [Chat] {
        return chats
    }
}
