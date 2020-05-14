//
//  ViewController.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let autheReposity = AuthenticateRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let param = LoginRequest(username: "duchv", password: "12345678")
        autheReposity.login(req: param, success: { [weak self] response in
            guard let self = self else { return }
            print(response)
        }) { [weak self] error in
            guard let self = self else { return }
            print(error)
        }
    }
}
