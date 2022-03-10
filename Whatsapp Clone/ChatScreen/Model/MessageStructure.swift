//
//  MessageStructure.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 09/03/22.
//

import Foundation

enum SenderType {
    case current, other
}

struct Message {
    var sender: SenderType
    var sentMessage: String
    var time: String
}

struct Messages {
    var id: Int
    var message: [Message]
}
