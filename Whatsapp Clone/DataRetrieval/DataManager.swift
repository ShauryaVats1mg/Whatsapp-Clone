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
    private var chats = [Chat]()
    
    init() {
        if let localData = self.readLocalFile() {
            self.parse(jsonData: localData)
        }
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
            let decodedData = try JSONDecoder().decode([Chat].self, from: jsonData)
            
            chats = decodedData
        }
        catch let error {
            print(error)
            print("decode error")
        }
    }
    
    func getChats() -> [Chat] {
        return chats
    }
}
