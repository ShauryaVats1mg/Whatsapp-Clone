//
//  MessageStructure.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 09/03/22.
//

import Foundation

struct Message {
    var sender: String
    var sentMessage: String
    var time: String
}

struct Messages {
    var id: Int
    var messages: [Message]
}
