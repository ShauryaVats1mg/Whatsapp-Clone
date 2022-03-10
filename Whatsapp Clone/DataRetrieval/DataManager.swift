//
//  DataManager.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 24/02/22.
//

import Foundation
import UIKit

private enum Constants {
    static let chatFilename = "ChatPerson"
}

class DataManager {
    private var chats = [UserDataStructure]()
    private var messages = [Messages]()
    
    init() {
        if let localData = self.readLocalFile() {
            self.parse(jsonData: localData)
        }
        
        messages.append(Messages(id: 0, message: [Message(sender: .current, sentMessage: "Hello World", time: "05:53"), Message(sender: .other, sentMessage: "Message", time: "05:53"), Message(sender: .current, sentMessage: "Message", time: "05:53"), Message(sender: .other, sentMessage: "Hello World", time: "05:53"), Message(sender: .current, sentMessage: "Message", time: "05:53")]))
    }
    
    private func readLocalFile() -> Data? {
        guard let bundlePath = Bundle.main.url(forResource: Constants.chatFilename, withExtension: "json") else{
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: bundlePath)
            return jsonData
        }
         catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([UserDataStructure].self, from: jsonData)
            
            chats = decodedData
        }
        catch let error {
            print(error)
            print("decode error")
        }
    }
    
    func getChats() -> [UserDataStructure] {
        return chats
    }
    
    func getMessages(at index: Int) -> [Message]? {
        if index < messages.count {
            return messages[index].message
        }
        return nil
    }
}
