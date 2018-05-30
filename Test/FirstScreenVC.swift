//
//  FirstScreenVC.swift
//  Test
//
//  Created by Admin on 28/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FirstScreenVC: UIViewController {

    @IBOutlet weak var authButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
