//
//  ContactAddViewController.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/4/30.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

protocol NewContactDelegate {
    func newContact(_ contact: Contact)
}

class ContactAddViewController: UIViewController {

    var delegate: NewContactDelegate?
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSourceCodeItem("contactadd")
        
    }
    
    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            let contact = Contact(avatarURL: "image", name: name.text, surname: surname.text, phone: phone.text, email: email.text)
            delegate.newContact(contact)
        }
        self.dismiss(animated: true, completion: nil)
    }

}
