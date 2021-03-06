//
//  ContactDetailViewController.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/4/30.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var contact = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact Info"
        
        self.addSourceCodeItem("contactdetail")
        
        icon = UIImageView.init(image: UIImage(named: contact.avatarURL))
        name.text = contact.name
        surname.text = contact.surname
        phone.text = contact.phone
        email.text = contact.email
    }

}
