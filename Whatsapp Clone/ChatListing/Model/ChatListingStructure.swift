//
//  ViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 24/02/22.
//

import Foundation
import UIKit

struct ChatListingStructure: Codable {
    var profilePic: URL?
    var name: String
    var time: String
    var lastMessage: String
    var isGroup: Bool
}
