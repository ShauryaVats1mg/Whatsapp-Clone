//
//  UIImageView.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 01/03/22.
//

import UIKit

extension UIView {
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
