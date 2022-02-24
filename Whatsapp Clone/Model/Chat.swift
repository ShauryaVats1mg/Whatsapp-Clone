//
//  ViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 24/02/22.
//

import Foundation

struct Chat {
    let name: String
    let time: Date
    let lastMessage: String
}

typealias ChatData = (name: String, time: String, lastMessage: String)

extension Chat {
    var tableRepresentation: ChatData {
        return (name, time.description, lastMessage)
    }
}
