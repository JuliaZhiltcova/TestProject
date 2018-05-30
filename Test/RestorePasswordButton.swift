//
//  GhostButton.swift
//  Test
//
//  Created by Admin on 29/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class RestorePasswordButton: UIButton {

    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    
    func setup(){
        
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor(red: 0xeb, green: 0xeb, blue: 0xeb).cgColor
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: 12)
        self.setTitleColor(UIColor(red: 0x79, green: 0x79, blue: 0x79), for: .normal)
        
    }
   
}
