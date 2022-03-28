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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
        addButton?.titleLabel?.text = ""
        cameraButton?.titleLabel?.text = ""
        micButton?.titleLabel?.text = ""
        
        textView?.makeRounded()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
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
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
