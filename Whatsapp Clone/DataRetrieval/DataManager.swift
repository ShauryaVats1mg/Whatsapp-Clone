//
//  DataManager.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 24/02/22.
//

import Foundation
import UIKit

class DataManager {
    private var chats = [Chat]()
    
    init() {
        chats.append(Chat(
            profilePic: nil,
            name: "Username 1",
            time: Date.distantPast,
            lastMessage: "This is the last message from the user named Name 1",
            isGroup: false
        ))
        
        chats.append(Chat(
            profilePic: nil,
            name: "Group 1",
            time: Date.distantPast,
            lastMessage: "",
            isGroup: true
        ))
        
        chats.append(Chat(
            profilePic: nil,
            name: "User 3",
            time: Date.distantPast,
            lastMessage: "This is the last message from the user named Name 3",
            isGroup: false
        ))
        
        chats.append(Chat(
            profilePic: nil,
            name: "User 4",
            time: Date.distantPast,
            lastMessage: "This is the last message",
            isGroup: false

        ))
    }
    
    func getChats() -> [Chat] {
        return chats
    }
}
