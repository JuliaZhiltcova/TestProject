//
//  CustomTextField.swift
//  Test
//
//  Created by Admin on 28/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CustomTextField: UITextField{
    
    private let titleLabelHeight = 15
    private let hintLabelHeight = 10
    private let floatingTitleLabelUpOffset = 3
    private var bottomLineLayer = CALayer()
    private var title = UILabel()
    private var hint = UILabel()
    
    private var activeBottomLineColor = UIColor.blue
    private var inactiveBottomLineColor = UIColor(red: 0xeb, green: 0xeb, blue: 0xeb)
    
    private var activeTitleLabelColor = UIColor.blue
    private var inactiveTitleLabelColor = UIColor(red: 0x79, green: 0x79, blue: 0x79)
    
    private var hintLabelColor = UIColor.red
    
    
    private var _pattern: String?
    var pattern: String? {
        get {
            return _pattern
        }
        set {
            _pattern = newValue
        }
    }
    
    private var _errorMessage: String?
    var errorMessage: String? {
        get {
            return _errorMessage
        }
        set {
            _errorMessage = newValue
        }
    }
    
    private var _titleText: String?
    var titleText: String?{
        get{
            return _titleText
        }
        set{
            _titleText = newValue
            title.text = _titleText
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
        
        title.text = _titleText
        title.alpha = 0
        title.font = UIFont(name: "SFUIText-Regular", size: 13)
        title.textColor = inactiveTitleLabelColor
        title.frame = CGRect(x:0, y: 0, width: Int(self.frame.size.width), height: titleLabelHeight)
        self.addSubview(title)
    
        hint.text = _errorMessage
        hint.alpha = 0
        hint.font = UIFont(name: "SFUIText-Regular", size: 10)
        hint.textColor = hintLabelColor
        
        self.addSubview(hint)
        
        bottomLineLayer.backgroundColor = inactiveBottomLineColor.cgColor
        self.layer.addSublayer(bottomLineLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLineLayer.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        hint.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: CGFloat(hintLabelHeight) )
        
        
        if self.isFirstResponder {
            bottomLineLayer.backgroundColor = activeBottomLineColor.cgColor
            title.textColor = activeTitleLabelColor
            showTitleLabel()
        }
        if !self.isFirstResponder {
            bottomLineLayer.backgroundColor = inactiveBottomLineColor.cgColor
            title.textColor = inactiveTitleLabelColor
            if let userText = self.text, !userText.isEmpty && !isValid{
                self.textColor = UIColor.red
                showHintLabel()
            }
            if let userText = self.text, userText.isEmpty && !isValid || !userText.isEmpty && isValid  {
                self.hideHintLabel()
                self.textColor = UIColor(red: 0x33, green: 0x33, blue: 0x33)
            }
            if let userText = self.text, userText.isEmpty {
                hideTitleLabel()
                self.textColor = UIColor(red: 0x33, green: 0x33, blue: 0x33)
            }
        }
    }
    

    
    var isValid: Bool{
        get{
            guard let regex = try? NSRegularExpression(pattern: _pattern!, options: [.caseInsensitive]) else {
                return false
            }
            guard let text_ = self.text else {
                return false
            }
            let range = NSMakeRange(0, self.text!.characters.count)
            return regex.firstMatch(in: self.text!, options: [], range: range) != nil
        }
    }
    
    fileprivate func showTitleLabel() {
        UIView.animate(withDuration: 0.2, delay:0, options: [.curveEaseOut], animations:{
            self.title.text = self._titleText
            self.title.alpha = 1.0
            self.title.frame = CGRect(x:0, y:-self.titleLabelHeight-self.floatingTitleLabelUpOffset, width: Int(self.frame.size.width), height:self.titleLabelHeight)
        })
    }
    
    fileprivate func hideTitleLabel(){
        UIView.animate(withDuration: 0.2, delay:0, options: [.curveEaseOut], animations:{
            self.title.alpha = 0.0
            self.title.frame = CGRect(x:0, y: 0, width: Int(self.frame.size.width), height: self.titleLabelHeight)
        })
    }
    
    fileprivate func showHintLabel(){
        UIView.animate(withDuration: 0) { 
            self.hint.text = self._errorMessage
            self.hint.alpha = 1
        }
    }
    
    fileprivate func hideHintLabel(){
        UIView.animate(withDuration: 0) { 
            self.hint.alpha = 0
        }
    }
    
    
}
