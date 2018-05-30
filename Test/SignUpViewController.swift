//
//  ViewController.swift
//  Test
//
//  Created by Admin on 25/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var restorePasswordButton: RestorePasswordButton!
    @IBOutlet weak var submitButton: CustomButton!
    
    
    var textFields: [CustomTextField]!
    
    @IBAction func submitButtonPressed(_ sender: CustomButton) {
        let basePath = "https://api.darksky.net/forecast/232fd101dab40a873bf13007332a76b6/42.3601,-71.0589"
      
       Alamofire.request(basePath).responseJSON { response in
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200..<300:
                    if let json = response.result.value as? [String: Any] {
                        
                         
                        if let currently = json["currently"] as? [String: Any]{
                           
                            let summary = (currently["summary"] as? String) ?? ""
                            var temperature = (currently["temperature"] as? Double) ?? 0.0
                            let humidity = (currently["humidity"] as? Double) ?? 0.0
                        
               
                            temperature = ((temperature - 32) * 5 / 9).rounded()
                    
                            let forecast = "It's \(summary). The temperature is \(temperature) C. The humidity is \(String(humidity * 100))%."
                         
                    
                            let alertController = UIAlertController(title: "Weather forecast", message: forecast, preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                            
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)

                        }
                    }
                default:
                    print("error with response status: \(status)")
                }
            }
            

        }
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextField.delegate = self
        passwordTextField.delegate = self
        registerForKeyboardNotifications()
        
        textFields = [emailTextField, passwordTextField]
        
        emailTextField.titleText = "Почта"
        passwordTextField.titleText = "Пароль"
       
        emailTextField.errorMessage = "Электронный адрес указан неверно"
        passwordTextField.errorMessage = "Пароль должен содержать 1 заглавную, 1 строчную букву и 1 цифру"
        
        emailTextField.pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        passwordTextField.pattern = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
        
        //submitButton.isEnabled = false
        
    }
    

    override func viewWillLayoutSubviews() {
        scrollView.contentInset = UIEdgeInsets(top: -topLayoutGuide.length, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setConstraints()
        let navigationBar = self.navigationController?.navigationBar
        self.title = "Авторизация"
        
        let attributes: [String: AnyObject] = [
            NSForegroundColorAttributeName: UIColor(red: 0x33, green: 0x33, blue: 0x33),
            NSFontAttributeName: UIFont(name: "SFUIText-Medium", size: 17)!
        ]
        navigationBar?.titleTextAttributes = attributes
        navigationBar?.backgroundColor = UIColor.white
        navigationBar?.isTranslucent = false
    }
    
    deinit {
        removeKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func kbWillShow(_ notification: Notification){
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height / 3)
    }
    
   
    var isFillingForm = false                            // переводим курсор на следующее поле
    var isLandScape = false                              // устройство в LandScape-ориентации
    
    func kbWillHide(){
        if isFillingForm && !isLandScape{ return }       // в LandScape убираем клавиатуру после ввода в каждое поле
        scrollView.contentOffset = CGPoint.zero
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        isLandScape = UIDevice.current.orientation.isLandscape
        
        if isLandScape {
            emailTextField.returnKeyType = .default
            isFillingForm = false
        } else {
            emailTextField.returnKeyType = .next
            isFillingForm = true
        }
    }

}

// TextFieldDelegate methods
extension SignUpViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if !isLandScape {
            isFillingForm = textField.tag == 0
        }
        
        submitButton.isEnabled = emailTextField.isValid && passwordTextField.isValid
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeNextTextFieldFirstResponder(textField)
        submitButton.isEnabled = emailTextField.isValid && passwordTextField.isValid
        return true
    }
    
    func makeNextTextFieldFirstResponder(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        if !isFillingForm { return }
        let currentTag = textField.tag
        let nextTag = currentTag + 1
        if nextTag > textFields.count{return}
        
        let nextTextField = self.view.viewWithTag(nextTag)
        nextTextField?.becomeFirstResponder()
        
    }


}

// Constraints
extension SignUpViewController {

    func setConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 0).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: -55).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16).isActive = true
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 39).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 147).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        createAccountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        createAccountLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 21).isActive = true
        
        restorePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        restorePasswordButton.widthAnchor.constraint(equalToConstant: 113).isActive = true
        restorePasswordButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        restorePasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 0).isActive = true
        restorePasswordButton.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -8).isActive = true
    }

}



