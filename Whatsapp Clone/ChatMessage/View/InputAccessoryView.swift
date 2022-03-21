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
    @IBOutlet weak var cameraButton: UIButton?
    @IBOutlet weak var micButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
        addButton?.titleLabel?.text = ""
        cameraButton?.titleLabel?.text = ""
        micButton?.titleLabel?.text = ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("InputAccessoryView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
