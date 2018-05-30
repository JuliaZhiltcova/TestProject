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

        
        let color = UIColor.white
        let disabledColor = color.withAlphaComponent(0.3)
      
        self.backgroundColor = UIColor(red: 0xFF, green: 0x9b, blue: 0x00)

       // let bthWidth = 147
       // let btnHeight = 44
       // self.frame.size = CGSize(width: bthWidth, height: btnHeight)


        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
       
        
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(disabledColor, for: .disabled)
        
           
    }
 
    

    
}
