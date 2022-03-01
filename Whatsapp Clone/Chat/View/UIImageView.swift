//
//  UIImageView.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 01/03/22.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        self.frame = CGRect(x: frame.midX, y: frame.midY, width: frame.height, height: frame.height)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
