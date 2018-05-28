//
//  CustomButton.swift
//  Test
//
//  Created by Admin on 28/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    
    func setup(){
        let enabledColor = UIColor.white
        let disabledColor = enabledColor.withAlphaComponent(0.3)
        let backgroundColor = UIColor(red: 0xFF, green: 0x9b, blue: 0x00)
        
        let bthWidth = 147.0
        let btnHeight = 44.0
        
        self.frame.size = CGSize(width: bthWidth, height: btnHeight)
        
        self.layer.cornerRadius = 28.0
        self.clipsToBounds = true
       // self.layer.borderWidth = 3.0
        
        //self.layer.borderColor = enabledColor.cgColor
        self.backgroundColor = backgroundColor
        
        self.setTitleColor(enabledColor, for: .normal)
        self.setTitleColor(disabledColor, for: .disabled)
        
       // self.titleLabel?.font = UIFont(name: btnFont, size: 25)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
        
        //self.contentEdgeInsets.bottom = 4
        
    }
    
}
