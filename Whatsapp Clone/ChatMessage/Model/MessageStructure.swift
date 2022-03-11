//
//  MessageStructure.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 09/03/22.
//

import Foundation

enum SenderType: String, Codable {
    case current = "current"
    case other = "other"
}

struct Message: Codable {
    var sender: SenderType
    var sentMessage: String
    var time: String
}

struct Messages: Codable {
    var id: Int
    var message: [Message]
}
