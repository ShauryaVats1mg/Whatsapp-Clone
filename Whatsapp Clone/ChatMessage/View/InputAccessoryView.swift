//
//  InputAccessoryView.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 15/03/22.
//

import UIKit

class InputAccessoryView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var addButton: UIButton?
    @IBOutlet weak var textView: UITextView?
    @IBOutlet weak var cameraButton: UIButton?
    @IBOutlet weak var micButton: UIButton?
    @IBOutlet weak var sendButton: UIButton?
    
    override var intrinsicContentSize: CGSize {
        let size = textView?.sizeThatFits(CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude))
        return CGSize(width: bounds.width, height: size?.height ?? contentView.bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
        addButton?.titleLabel?.text = ""
        cameraButton?.titleLabel?.text = ""
        micButton?.titleLabel?.text = ""
        sendButton?.titleLabel?.text = ""
        
        sendButton?.isHidden = true
        //sendButton?.makeRounded()
        //textView?.makeRounded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if #available(iOS 11.0, *) {
            if let window = self.window {
                self.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: window.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0).isActive = true
            }
        }
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("InputAccessoryView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        textView?.translatesAutoresizingMaskIntoConstraints = false
        textView?.delegate = self
        textView?.isScrollEnabled = false
    }
}

extension InputAccessoryView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            cameraButton?.isHidden = true
            micButton?.isHidden = true
            sendButton?.isHidden = false
        }
        else {
            cameraButton?.isHidden = false
            micButton?.isHidden = false
            sendButton?.isHidden = true
        }
        self.invalidateIntrinsicContentSize()
    }
}
