//
//  API.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 24/02/22.
//

import UIKit

final class API {
    
    static let instance = API()
    private let dataManager = DataManager()
    
    private init(){}
    
    func getChats() -> [UserDataStructure] {
        return dataManager.getChats()
    }
    
    func getMessages(at index: Int) -> [Message]? {
        return dataManager.getMessages(at: index)
    }
}
