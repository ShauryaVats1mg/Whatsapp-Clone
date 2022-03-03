//
//  MessageViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 25/02/22.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
