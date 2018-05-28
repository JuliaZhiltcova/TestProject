//
//  CustomTextField.swift
//  Test
//
//  Created by Admin on 28/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CustomTextField: UITextField{
    
    let floatingTitleLabelHeight = 15
    let floatingTitleLabelUpOffset = 3
    var bottomLineLayer = CALayer()
    var title = UILabel()
    
    var activeBottomLineColor = UIColor.blue
    var inactiveBottomLineColor = UIColor.gray
    var errorBottomLineColor:UIColor = UIColor.red
    
    var activeTitleLabelColor = UIColor.blue
    var inactiveTitleLabelColor = UIColor.gray
    var errorTitleLabelColor:UIColor = UIColor.red
    
    
    private var _pattern: String?
    var pattern: String? {
        get {
            return _pattern
        }
        set {
            _pattern = pattern
        }
    }
    
    private var _titleText: String?
    var titleText: String?{
        get{
            return _titleText
        }
        set{
            _titleText = titleText
        }
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    fileprivate func setup() {
        borderStyle = UITextBorderStyle.none
        
        title.alpha = 0
        title.text = self.placeholder
        title.font = UIFont(name: "Helvetica", size: 14)//titleFont
        title.textColor = UIColor.gray//titleActiveTextColor
        title.frame = CGRect(x:0, y: 0, width: Int(self.frame.size.width), height:floatingTitleLabelHeight)
        self.addSubview(title)
        
        bottomLineLayer.backgroundColor = UIColor.gray.cgColor  //red.cgColor.copy(alpha: 0.5)
        bottomLineLayer.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(bottomLineLayer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if self.isFirstResponder {
            bottomLineLayer.backgroundColor = activeBottomLineColor.cgColor
            title.textColor = activeTitleLabelColor
            showTitleLabel()
        }
        if !self.isFirstResponder {
            bottomLineLayer.backgroundColor = inactiveBottomLineColor.cgColor
            title.textColor = inactiveTitleLabelColor
            if let userText = self.text, userText.isEmpty {
                hideTitleLabel()
            }
            
        }
        
    }
    
    fileprivate func showTitleLabel() {
        
        UIView.animate(withDuration: 0.2, delay:0, options: [.curveEaseOut], animations:{
            
            self.title.text = self.placeholder
            self.title.alpha = 1.0
            self.title.frame = CGRect(x:0, y:-self.floatingTitleLabelHeight-self.floatingTitleLabelUpOffset, width: Int(self.frame.size.width), height:self.floatingTitleLabelHeight)
            
        }, completion:{ _ in
            
        })
    }
    
    fileprivate func hideTitleLabel(){
        
        UIView.animate(withDuration: 0.2, delay:0, options: [.curveEaseOut], animations:{
            
            self.title.alpha = 0.0
            self.title.frame = CGRect(x:0, y: 0, width: Int(self.frame.size.width), height: self.floatingTitleLabelHeight)
            
        }, completion:{ _ in
            
        })
    }
    
    
}
