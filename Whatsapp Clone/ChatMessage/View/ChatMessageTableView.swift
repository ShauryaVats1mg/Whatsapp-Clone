//
//  ChatMessageTableView.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 28/03/22.
//

import UIKit

class ChatMessageTableView: UITableView {

    lazy var inputAccessory: InputAccessoryView = {
        let inputAccessory = InputAccessoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56))
        //inputAccessory.autoresizesSubviews = false
        return inputAccessory
    }()
    
    override var inputAccessoryView: UIView? {
      return inputAccessory
    }
    
    override var canBecomeFirstResponder: Bool {
      return true
    }
    
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.contentInset.bottom = keyboardHeight
        if keyboardHeight > 100 {
          scrollToBottom()
        }
      }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.contentInset.bottom = keyboardHeight
      }
    }
}
