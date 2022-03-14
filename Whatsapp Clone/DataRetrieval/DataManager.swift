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
    static let messageFilename = "ChatMessages"
}

class DataManager {
    private var chats = [ChatListingStructure]()
    private var messages = [Messages]()
    
    init() {
        if let localData = readLocalFile(Constants.chatFilename) {
            parseChats(jsonData: localData)
        }
        
        if let localData = readLocalFile(Constants.messageFilename) {
            parseMessages(jsonData: localData)
        }
    }
    
    private func readLocalFile(_ fileName: String) -> Data? {
        guard let bundlePath = Bundle.main.url(forResource: fileName, withExtension: "json") else{
            print("File not found")
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
    
    private func parseChats(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([ChatListingStructure].self, from: jsonData)
            
            chats = decodedData
        }
        catch let error {
            print(error)
            print("decode error")
        }
    }
    
    private func parseMessages(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([Messages].self, from: jsonData)
            
            messages = decodedData
        }
        catch let error {
            print(error)
            print("Decode error")
        }
    }
    
    func getChats() -> [ChatListingStructure] {
        return chats
    }
    
    func getMessages(at index: Int) -> [Message]? {
        if index < messages.count {
            return messages[index].message
        }
        return nil
    }
}
