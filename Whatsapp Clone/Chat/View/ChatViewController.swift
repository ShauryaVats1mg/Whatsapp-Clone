//
//  MessageViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 25/02/22.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton?
    @IBOutlet weak var messageFeild: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Hide the tab bar
        tabBarController?.tabBar.isHidden = true
        
        //Initialise the navigation bar
        navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //Initialise the bottom bar
        if let sendButton = sendButton {
            sendButton.makeRounded()
        }
        
        if let messageFeild = messageFeild {
            messageFeild.makeRounded()
        }
    }
    
    func setup(_ chatDetails: Cell?) {
        guard let _ = chatDetails else {
            return;
        }
        
        title = chatDetails?.name.text
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        
        navigationItem.leftBarButtonItems = [backButton]
        
        let videoButton = UIBarButtonItem(image: UIImage(systemName: "video"), style: .plain, target: nil, action: nil)
        
        let callButton = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [callButton, videoButton]
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Deinitialise the navigation bar
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Un hide the tab bar
        tabBarController?.tabBar.isHidden = false
    }

}
