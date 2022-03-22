//
//  MessageViewController.swift
//  Whatsapp Clone
//
//  Created by Shaurya on 25/02/22.
//

import UIKit

class ChatMessageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    private var chatMessages: [Message]
    private var chatListingDetails: ChatListingStructure
    
    lazy var inputAccessory: InputAccessoryView = {
        let inputAccessory = InputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        inputAccessory.autoresizesSubviews = false
        return inputAccessory
    }()
    
    //MARK: Class Initialisers
    
    init?(coder: NSCoder, chatDetails: ChatListingStructure, chatIndex: Int) {
        self.chatListingDetails = chatDetails
        self.chatMessages = API.instance.getChatMessages(at: chatIndex) ?? []
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) should not have been called. Call init(coder:ChatListingStructure:Int) to initialise this class")
    }
    
    //MARK: View Controller Overrides
    
    override var inputAccessoryView: UIView? {
        get {
            return inputAccessory
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override var canResignFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Hide the tab bar
        tabBarController?.tabBar.isHidden = true
        
        //Initialise the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //Initialising the table view
        tableView?.delegate = self
        tableView?.dataSource = self
        
        setupNavigationBar()
        
        setupInputTextField()
        
        tableView?.keyboardDismissMode = .interactive
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Deinitialise the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Un hide the tab bar
        tabBarController?.tabBar.isHidden = false
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Navigation Bar Setup
    
    func setupLeftNavigationBarItems() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonPressed))
        
        /*let profilePicButton = UIButton(type: .custom)
        profilePicButton.setBackgroundImage(chatDetails?.profilePic.image, for: .normal)
        profilePicButton.imageView?.contentMode = .scaleAspectFit
        profilePicButton.imageView?.makeRounded()
        
        navigationItem.leftBarButtonItems = [backButton, UIBarButtonItem(customView: profilePicButton)]
        */
                
        let profilePicButton = UIButton(type: .custom)
        let imageView = profilePicButton.imageView
        imageView?.image = (chatListingDetails.isGroup) ? ChatDefaults.groupProfilePic: ChatDefaults.userProfilePic
        imageView?.backgroundColor = UIColor.lightGray
        imageView?.tintColor = UIColor.systemBackground
        profilePicButton.setBackgroundImage(imageView?.image?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        let nameButton = UILabel()
        nameButton.text = chatListingDetails.name
        nameButton.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        navigationItem.leftBarButtonItems = [backButton, UIBarButtonItem(customView: profilePicButton), UIBarButtonItem(customView: nameButton)]
    }
    
    func setupRightNavigationBarItems() {
        let videoButton = UIBarButtonItem(image: UIImage(systemName: "video"), style: .plain, target: nil, action: nil)
        
        let callButton = UIBarButtonItem(image: UIImage(systemName: "phone"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [callButton, videoButton]
    }
    
    func setupNavigationBar() {
        setupLeftNavigationBarItems()
        
        setupRightNavigationBarItems()
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Setup Input Text Field
    
    func setupInputTextField() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private var isKeyboardShowing: Bool = false
    
    @objc func adjustKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            if !isKeyboardShowing {
                view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardViewEndFrame.height)
                isKeyboardShowing = true
            }
        }
        else {
            if isKeyboardShowing {
                view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + keyboardViewEndFrame.height)
                isKeyboardShowing = false
            }
        }
    }
}

// MARK: - Table View Extension

extension ChatMessageViewController: UITableViewDelegate, UITableViewDataSource {
    private enum Constants {
        static let sendCellIdentifier = "SendCell"
        static let recieveCellIdentifier = "RecieveCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatMessages[indexPath.section]
        if(message.sender == .current) {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.sendCellIdentifier, for: indexPath) as! MessageSendTableViewCell
            cell.message.text = message.sentMessage
            cell.time.text = message.time
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.recieveCellIdentifier, for: indexPath) as! MessageRecieveTableViewCell
        cell.message.text = message.sentMessage
        cell.time.text = message.time
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
}
