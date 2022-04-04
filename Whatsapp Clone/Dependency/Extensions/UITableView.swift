//
//  UITableView.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 25/03/22.
//

import UIKit

extension UITableView {
    func scrollToBottom(animated: Bool = true, scrollPostion: UITableView.ScrollPosition = .bottom) {
        let no = self.numberOfRows(inSection: 0)
        if no > 0 {
            let index = IndexPath(row: no - 1, section: 0)
            scrollToRow(at: index, at: scrollPostion, animated: animated)
        }
    }
}
